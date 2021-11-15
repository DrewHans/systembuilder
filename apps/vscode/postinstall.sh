#!/usr/bin/env bash

# check if vscode is installed
command -v code >/dev/null 2>&1 && {
    echo "installing vscode extensions"

    sudo -u ${sudo_user_username} \
        code --install-extension material-icon-theme

    sudo -u ${sudo_user_username} \
        code --install-extension ms-vscode.cpptools

    sudo -u ${sudo_user_username} \
        code --install-extension ms-python.python

    sudo -u ${sudo_user_username} \
        code --install-extension ms-python.vscode-pylance

    echo ""
}