#!/bin/bash

# Get path to script directory
if [ -n "${BASH_SOURCE[0]}" ]; then
  DIR=$(dirname "${BASH_SOURCE[0]}")
elif [ -n "${0}" ]; then
  DIR=$(dirname "$(readlink -f "$0")")
fi

# Include config
. "${DIR}/ssh-login-notification.conf"

# Collect information
TIME="$(date +%d.%m.%Y) $(date +%H:%M)"
SERVER_NAME="$(hostname -s)"
SERVER_IP="$(hostname -i)"
SERVER_PORT="$(echo "${SSH_CONNECTION}" | cut -d " " -f 4)"
SERVER_FQDN="$(hostname -f)"
CLIENT_IP="$(echo "${SSH_CONNECTION}" | cut -d " " -f 1)"
CLIENT_FQDN="$(nslookup "${CLIENT_IP}" | grep "name =" | cut -d " " -f 3)"

# Prepare mail
read -r -d '' MAIL <<MAIL
${MESSAGE}

Time: ${TIME}
Server: ${SERVER_NAME}
User: ${USER}

Server IP: ${SERVER_IP}
Server Port: ${SERVER_PORT}
Server FQDN: ${SERVER_FQDN}

Client IP: ${CLIENT_IP}
Client FQDN: ${CLIENT_FQDN}
MAIL

# Send mail
echo "${MAIL}" | mailx -s "${SUBJECT}" "${RECEIVER}"
