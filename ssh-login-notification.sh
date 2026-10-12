#!/bin/bash

# This file ist part of the MotD project, see https://gitlab.com/bloodhunterd-labs/tools/SSH-Login-Notification.
# © 2023 by BloodhunterD <bloodhunterd@bloodhunterd.com>

# Get path to script directory
if [ -n "${BASH_SOURCE[0]}" ]; then
  DIR=$(dirname "${BASH_SOURCE[0]}")
elif [ -n "${0}" ]; then
  DIR=$(dirname "$(readlink -f "$0")")
fi

# Include config
. "${DIR}/ssh-login-notification.conf"

# Defaults
MAIL_ENABLED="${MAIL_ENABLED:-true}"
WEBHOOK_ENABLED="${WEBHOOK_ENABLED:-false}"
WEBHOOK_METHOD="${WEBHOOK_METHOD:-POST}"
WEBHOOK_CONTENT_TYPE="${WEBHOOK_CONTENT_TYPE:-application/json}"
if [ -z "${WEBHOOK_TEMPLATE}" ]; then
  WEBHOOK_TEMPLATE='{"text":"{{TEXT}}"}'
fi

# Collect information
TIME="$(date +%d.%m.%Y) $(date +%H:%M)"
SERVER_NAME="$(hostname -s)"
SERVER_IP="$(hostname -i)"
SERVER_PORT="$(echo "${SSH_CONNECTION}" | cut -d " " -f 4)"
SERVER_FQDN="$(hostname -f)"
CLIENT_IP="$(echo "${SSH_CONNECTION}" | cut -d " " -f 1)"
CLIENT_FQDN="$(nslookup "${CLIENT_IP}" | grep "name =" | cut -d " " -f 3)"

# Prepare notification text
read -r -d '' TEXT <<TEXT
${MESSAGE}

Time: ${TIME}
Server: ${SERVER_NAME}
User: ${USER}

Server IP: ${SERVER_IP}
Server Port: ${SERVER_PORT}
Server FQDN: ${SERVER_FQDN}

Client IP: ${CLIENT_IP}
Client FQDN: ${CLIENT_FQDN}
TEXT

# Send mail
if [ "${MAIL_ENABLED}" = "true" ]; then
  echo "${TEXT}" | mailx -s "${SUBJECT}" "${RECEIVER}"
fi

# Escape a string for use inside a JSON string
ssh_login_notification_json_escape() {
  local VALUE="${1}"
  VALUE="${VALUE//\\/\\\\}"
  VALUE="${VALUE//\"/\\\"}"
  VALUE="${VALUE//$'\n'/\\n}"
  VALUE="${VALUE//$'\r'/\\r}"
  VALUE="${VALUE//$'\t'/\\t}"
  printf '%s' "${VALUE}"
}

# Send webhook
if [ "${WEBHOOK_ENABLED}" = "true" ]; then
  WEBHOOK_PAYLOAD="${WEBHOOK_TEMPLATE}"
  for WEBHOOK_KEY in TEXT MESSAGE SUBJECT TIME USER SERVER_NAME SERVER_IP SERVER_PORT SERVER_FQDN CLIENT_IP CLIENT_FQDN; do
    WEBHOOK_VALUE="$(ssh_login_notification_json_escape "${!WEBHOOK_KEY}")"
    WEBHOOK_PAYLOAD="${WEBHOOK_PAYLOAD//\{\{${WEBHOOK_KEY}\}\}/"${WEBHOOK_VALUE}"}"
  done

  WEBHOOK_ARGS=(--silent --show-error --fail --max-time 10 -X "${WEBHOOK_METHOD}" -H "Content-Type: ${WEBHOOK_CONTENT_TYPE}")
  for WEBHOOK_HEADER in "${WEBHOOK_HEADERS[@]}"; do
    WEBHOOK_ARGS+=(-H "${WEBHOOK_HEADER}")
  done

  # Send in background to not delay the login
  (curl "${WEBHOOK_ARGS[@]}" --data "${WEBHOOK_PAYLOAD}" "${WEBHOOK_URL}" >/dev/null 2>&1 &)
fi

# Clean up, as the script is sourced into the login shell
unset -f ssh_login_notification_json_escape
unset WEBHOOK_PAYLOAD WEBHOOK_KEY WEBHOOK_VALUE WEBHOOK_ARGS WEBHOOK_HEADER
