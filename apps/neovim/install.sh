#!/usr/bin/env bash

sudo -u ${SUDO_USER:-$USER} \
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

chmod u+x nvim.appimage

mv nvim.appimage /home/${SUDO_USER:-$USER}/.local/bin/nvim