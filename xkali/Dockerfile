FROM kalilinux/kali-rolling

RUN apt update

RUN DEBIAN_FRONTEND=noninteractive apt install -y \
                      kali-tools-top10

RUN apt install -y \
      dirbuster \
      ffuf \
      wpscan \
      wordlists \
      bpython \
      python3 \
      python3-impacket \
      virtualenv \
      virtualenvwrapper \
      neofetch \
      exploitdb \
      zsh

RUN useradd $USER -m
RUN chsh -s /usr/bin/zsh $USER

expose 8000
expose 8080
expose 1337
expose 9999 

CMD burpsuite
