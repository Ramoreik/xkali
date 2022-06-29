#!/bin/bash

echo "[*] Removing permissions for X sharing."

echo "[+] # xhost -si:localuser:${USER}"
xhost "-si:localuser:${USER}" > /dev/null

echo "[*] Stopping xkali -"
docker-compose kill 
