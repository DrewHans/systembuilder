#!/usr/bin/env bash

if [ ! -f "/etc/apt/trusted.gpg.d/microsoft.gpg" ]; then
    touch microsoft.gpg
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    mkdir -p /etc/apt/trusted.gpg.d/
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    chmod 644 /etc/apt/trusted.gpg.d/microsoft.gpg
fi

if [ ! -f "/etc/apt/sources.list.d/vscode.list" ]; then
    mkdir -p /etc/apt/sources.list.d/
    touch /etc/apt/sources.list.d/vscode.list
    chmod 644 /etc/apt/sources.list.d/vscode.list
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
fi
