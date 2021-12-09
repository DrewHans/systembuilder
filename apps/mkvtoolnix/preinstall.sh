#!/usr/bin/env bash

if [ ! -f "/etc/apt/sources.list.d/mkvtoolnix.download.list" ]; then
    sudo wget -O /usr/share/keyrings/gpg-pub-moritzbunkus.gpg https://mkvtoolnix.download/gpg-pub-moritzbunkus.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/ubuntu/ hirsute main"|sudo tee /etc/apt/sources.list.d/mkvtoolnix.download.list
    echo "deb-src [arch=amd64 signed-by=/usr/share/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/ubuntu/ hirsute main"|sudo tee -a /etc/apt/sources.list.d/mkvtoolnix.download.list
fi
