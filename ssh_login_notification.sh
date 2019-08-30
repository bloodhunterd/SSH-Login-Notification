#!/bin/bash

# Get script directory path
DIR=$(dirname "$(readlink -f "$0")")

# Include config
. "${DIR}/ssh_login_notification.conf"

# Collect information
IP=$(echo "${SSH_CONNECTION}" | cut -d " " -f 1)
PORT=$(echo "${SSH_CONNECTION}" | cut -d " " -f 4)
DNS=$(nslookup "${IP}" | grep "name =" | cut -d " " -f 3)

# Prepare mail
read -r -d '' MAIL <<MAIL
${MESSAGE}

User: ${USER}
Server: $(hostname)
Port: ${PORT}

IP: ${IP}
DNS: ${DNS}
Time: $(date +%d.%m.%Y) $(date +%H:%M)
MAIL

# Send mail
echo "${MAIL}" | mailx -s "${SUBJECT}" ${RECEIVER}
