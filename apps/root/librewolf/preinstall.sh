#!/usr/bin/env bash


echo "deb [arch=amd64] http://deb.librewolf.net $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/librewolf.list

wget https://deb.librewolf.net/keyring.gpg -O /etc/apt/trusted.gpg.d/librewolf.gpg
