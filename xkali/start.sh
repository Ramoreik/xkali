#!/bin/bash

echo "[*] Setting up permissions to share X with the container."

echo "[+] # xhost +si:localuser:${USER}"
xhost "+si:localuser:${USER}" > /dev/null

echo "[*] Launching Xkali -"
docker-compose up
