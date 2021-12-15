#!/usr/bin/env bash

# check if vscode is installed
command -v code >/dev/null 2>&1 && {
    echo "installing vscode extensions"

    code --install-extension material-icon-theme

    code --install-extension ms-vscode.cpptools

    code --install-extension ms-python.python

    code --install-extension ms-python.vscode-pylance

    echo ""
}
