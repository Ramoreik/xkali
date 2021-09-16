# X-Kali service
This is a small script and docker/docker-compose container setup that creates an underlying kali instance.
If you change setup you might need to manually modify the $DISPLAY variable that the service feeds to docker-compose.
I used compose instead of a single docker command to let people modify it easily and add other services they might want start when pentesting.

### Installation
I have written a small script that will setup the whole installation automagically.
It installs the files in /opt/xkali and drops the service unit file in /etc/systemd/system/xkali.service.

THE USER HAS TO BE PART OF THE DOCKER GROUP.
For now this is the way it's configured to simplify setting up the X server permissions.


The script will use $USER and $DISPLAY to set the correct values.
```bash
$ bash setup.sh
  _  _    _  _    _   _    ___
 \ \/ /__| |/ /  /_\ | |  |_ _|
  >  <___| ' <  / _ \| |__ | |
 /_/\_\  |_|\_\/_/ \_\____|___|

[*] This script will install xkali and setup the service.
[!] !! This script  is intended to be run directly in the root of the repo (relative paths are used). !!
[!] This script uses the $USER and $DISPLAY env variables.
[?] Continue ? [y/n]: y

[+] # which docker
[+] # which docker-compose
[+] # sudo mkdir /opt/xkali
[+] # sudo chown gh0st:gh0st /opt/xkali
[+] # cp xkali/* /opt/xkali
[+] # sudo sed -i.bak 's/{ DISPLAY }/:1/' xkali.service
[+] # sudo sed -i.bak 's/{ USER }/gh0st/' xkali.service
[+] # sudo cp xkali.service /etc/systemd/system/
[+] # sudo systemctl enable --now xkali
[+] # cp xkali.env ~/.xkali.env
[+] # echo '. ~/.xkali.env' >> ~/.bashrc
[+] # echo '. ~/.xkali.env' >> ~/.zshrc
[+] # xhost +si:localuser:gh0st

[+] Done, Xkali should be running.

```

Once this script is done, normally burpsuite should pop up after image creation.  
For now the process that keeps the container alive if burpsuite,  
but this might change.

To monitor the creation you can use:
```
journalctl -fu xkali
```

I simply did this because burpsuite is open 100% of the time while i pentest.

