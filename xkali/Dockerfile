FROM kalilinux/kali-rolling

# ARGS
ARG USER
ARG SPACEVIM

# Installing Packages
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y \
                      kali-tools-top10 \
		      kali-tools-web \
		      kali-tools-vulnerability \
		      kali-tools-fuzzing \
		      chisel \
		      nvim

RUN apt install -y \
      bpython \
      build-essential \
      cmake \
      dirbuster \
      dnsutils \
      exploitdb \
      ffuf \
      ftp \
      iputils-ping \
      python3 \
      python3-pip \
      python3-impacket \
      neofetch \
      ncat \
      nikto \
      nnn \
      smbmap \
      sqlmap \
      tmux \
      traceroute \
      vim \
      virtualenv \
      virtualenvwrapper \
      wpscan \
      wordlists \
      zsh

RUN pip3 install \
      autoflake \
      coverage \
      isort \
      jedi \
      pylint \
      yapf

# Setting up unpriv user
RUN useradd $USER -m
RUN chsh -s /usr/bin/zsh $USER


# Changing to unpriv
USER $USER 

# Setting up optional softwares (my personal preferences)
RUN if [ -z $SPACEVIM ]; \
    then \
      echo "[-] SPACEVIM ARG not found, skipping."; \
    else \
      echo "[+] SPACEVIM ARG found, launching installation."; \
      /usr/bin/bash -c \
        "curl -sLf https://spacevim.org/install.sh | bash"; \
    fi

# RUSTLANG
RUN if [ -z $RUSTUP ]; \
    then \
      echo "[-] RUSTUP ARG not found, skipping."; \
    else \
      echo "[+] RUSTUP ARG found, launching installation."; \
      /usr/bin/bash -c \
        "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -y | sh"; \
    fi

# Node Version Manager 
RUN if [-z $NVM ]; \
    then \
      echo "[-] NVM ARG not found, skipping."; \
    else \
      echo "[+] NVM ARG found, launching installation."; \
      /usr/bin/bash -c \
        "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash"; \
    fi

# Starting main process (burp for now)
CMD burpsuite

