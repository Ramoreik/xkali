#!/bin/bash
set -e

cat << EOF
  _  _    _  _    _   _    ___ 
 \ \/ /__| |/ /  /_\ | |  |_ _|
  >  <___| ' <  / _ \| |__ | |
 /_/\_\  |_|\_\/_/ \_\____|___|

EOF

echo "[*] This script will install xkali and setup the service."
echo "[!] !! This script  is intended to be run directly in the root of the repo (relative paths are used). !!"
echo -e "[!] This script uses the \$USER and \$DISPLAY env variables.\n"

read -p "[?] Continue ? [y/n]: "
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  echo "[*] Exiting gracefully."
  exit 0
fi

### Checks 
# TODO: refine validation and handling for these lazy checks
echo -e "\n[*] Validations ..."
echo  "[+] # which docker"
which docker > /dev/null

echo "[+] # which docker-compose"
which docker-compose >/dev/null

echo "[+] checking: -z \$DISPLAY"
if [ -z $DISPLAY ];then
  echo -e "\n[!] The DISPLAY environment variable does not seem set."
  exit 1
fi 

echo "[+] checking: -z \$USER"
if [ -z $USER ];then
  echo -e "\n[!] The USER environment variable does not seem set."
  exit 1
fi

if ! id -Gn|grep -qw 'docker';then
  echo -e "\n[!] The ${USER} user does not seem to be a member of the 'docker' group."
  echo "[?] You can add it with :$ sudo usermod -aG docker ${USER}."
  echo "[?] You can then logout and log back in.(or su - ${USER})"
  exit 0
fi

### Installing Xkali
echo -e "\n[*] Installation ..."
if [[ -d /opt/xkali ]]
then
  read -p "[?] /opt/xkali directory exists, reinstall ? [y/n]: " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "[+] sudo rm -rf /opt/xkali"
    sudo rm -rf /opt/xkali
  else
    echo "[!] Exiting gracefully."
    exit 0
  fi
fi

echo "[+] # sudo mkdir /opt/xkali"
sudo mkdir /opt/xkali

echo "[+] # sudo chown ${USER}:${USER} /opt/xkali"
sudo chown "${USER}:${USER}" /opt/xkali

echo "[+] # cp xkali/* /opt/xkali"
cp xkali/* /opt/xkali/

echo "[+] # cp xkali.service tmp.xkali.service"
cp xkali.service tmp.xkali.service

echo "[+] # sudo sed -i 's/{ DISPLAY }/${DISPLAY}/' tmp.xkali.service"
sudo sed -i "s/{ DISPLAY }/${DISPLAY}/" tmp.xkali.service

echo "[+] # sudo sed -i 's/{ USER }/${USER}/' tmp.xkali.service"
sudo sed -i "s/{ USER }/${USER}/" tmp.xkali.service

echo "[+] # sudo cp tmp.xkali.service /etc/systemd/system/xkali.service"
sudo mv tmp.xkali.service /etc/systemd/system/xkali.service

echo "[+] # sudo systemctl enable --now xkali"
sudo systemctl enable --now xkali

### POST
# Make a function
echo -e "\n[*] POST Installation ..."
echo "[+] # cp xkali.env ~/.xkali.env"
cp xkali.env ~/.xkali.env

if [ -f ~/.bashrc ];then
  if ! grep -Fxq ". ~/.xkali.env" ~/.bashrc;
  then
    echo "[+] # echo '. ~/.xkali.env' >> ~/.bashrc" 
    echo -e "# XKali Alias file\n. ~/.xkali.env" >> ~/.bashrc
  fi
fi

if [ -f ~/.zshrc ];then
  if ! grep -Fxq ". ~/.xkali.env" ~/.zshrc;
  then
    echo "[+] # echo '. ~/.xkali.env' >> ~/.zshrc" 
    echo -e "# XKali Alias file\n. ~/.xkali.env" >> ~/.zshrc
  fi
fi

echo "[+] # xhost +si:localuser:${USER}"
xhost "+si:localuser:${USER}" > /dev/null

echo -e "\n[*] Done, Xkali should be building itself."
echo "[*] Monitor the creation: $ journalctl -fu xkali"

