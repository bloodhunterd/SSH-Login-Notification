#!/bin/bash

IP=$(echo "${SSH_CONNECTION}" | cut -d " " -f 1)
PORT=$(echo "${SSH_CONNECTION}" | cut -d " " -f 4)
DNS=$(nslookup "${IP}" | grep "name =" | cut -d " " -f 3)

echo "SSH login detected."
echo
echo "User: ${USER}"
echo "Server: $(hostname)"
echo "Port: ${PORT}"
echo
echo "IP: ${IP}"
echo "DNS: ${DNS}"
echo "Time: $(date +%d.%m.%Y) $(date +%H:%M)"