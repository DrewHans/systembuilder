#!/usr/bin/env bash

sudo cp ./vscode.list /etc/apt/sources.list.d/vscode.list

sudo chown root /etc/apt/sources.list.d/vscode.list
sudo chgrp root /etc/apt/sources.list.d/vscode.list
sudo chmod 644 /etc/apt/sources.list.d/vscode.list
