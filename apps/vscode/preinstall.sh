#!/usr/bin/env bash

if [ ! -f "/etc/apt/sources.list.d/vscode.list" ]; then
    sudo cp vscode.list /etc/apt/sources.list.d/vscode.list
    sudo chown root:root /etc/apt/sources.list.d/vscode.list
    sudo chmod 644 /etc/apt/sources.list.d/vscode.list
fi
