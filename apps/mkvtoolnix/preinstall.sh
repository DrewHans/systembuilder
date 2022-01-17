#!/usr/bin/env bash

if [ ! -f "/etc/apt/sources.list.d/mkvtoolnix.download.list" ]; then
    # get OS codename
    codename=$(lsb_release -sc)

    # save the gpg key for package verification
    sudo wget -O /usr/share/keyrings/gpg-pub-moritzbunkus.gpg https://mkvtoolnix.download/gpg-pub-moritzbunkus.gpg

    # update apt sources with the mkvtoolnix version for our OS codename
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/ubuntu/ $codename main" | sudo tee /etc/apt/sources.list.d/mkvtoolnix.download.list
    echo "deb-src [arch=amd64 signed-by=/usr/share/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/ubuntu/ $codename main" | sudo tee -a /etc/apt/sources.list.d/mkvtoolnix.download.list
fi
