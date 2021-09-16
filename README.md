# X-Kali service
This is a small script and docker/docker-compose container setup that creates an underlying kali instance.
If you change setup you might need to manually modify the $DISPLAY variable that the service feeds to docker-compose.
I used compose instead of a single docker command to let people modify it easily and add other services they might want start when pentesting.

### Installation
I have written a small script that will setup the whole installation automagically.
It installs the files in /opt/xkali and drops the service unit file in /etc/systemd/system/xkali.service.

The script will use $USER and $DISPLAY to set the correct values.
```bash
$ bash setup.sh
  _  _    _  _    _   _    ___
 \ \/ /__| |/ /  /_\ | |  |_ _|
  >  <___| ' <  / _ \| |__ | |
 /_/\_\  |_|\_\/_/ \_\____|___|

[*] This script will install xkali and setup the service.
[!] !! This script  is intended to be run directly in the root of the repo (relative paths are used). !!
[?] Continue ? [y/n]: y

[+] # which docker
[+] # which docker-compose
[+] # sudo mkdir /opt/xkali
[+] # sudo chown gh0st:gh0st /opt/xkali
[+] # cp xkali/* /opt/xkali
[+] # cp xkali.service.bak xkali.service
[+] # sudo sed -i.bak 's/{ DISPLAY }/:1/' xkali.service
[+] # sudo cp xkali.service /etc/systemd/system/
[+] # sudo systemctl enable --now xkali
[+] # xhost +si:localuser:gh0st

[+] Done, Xkali should be running.
```

Once this script is done, normally burpsuite should pop up.  
For now the process that keeps the container alive if burpsuite,  
but this might change.

I simply did this because burpsuite is open 100% of the time while i pentest.

