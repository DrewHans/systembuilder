#!/usr/bin/env bash

# if nvim is not already installed
command -v nvim >/dev/null 2>&1 || {
    sudo curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    sudo chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/bin/nvim
}
