#!/usr/bin/env bash

if [ ! -f "/etc/apt/trusted.gpg.d/microsoft.gpg" ]; then
    sudo touch microsoft.gpg
    sudo curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mkdir -p /etc/apt/trusted.gpg.d/
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo chmod 644 /etc/apt/trusted.gpg.d/microsoft.gpg
fi

if [ ! -f "/etc/apt/sources.list.d/vscode.list" ]; then
    sudo mkdir -p /etc/apt/sources.list.d/
    sudo touch /etc/apt/sources.list.d/vscode.list
    sudo chmod 644 /etc/apt/sources.list.d/vscode.list
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
fi
