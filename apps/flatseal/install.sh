#!/usr/bin/env bash

# if flatpak is on system
command -v flatpak >/dev/null 2>&1 && {
    # install through flatpak
    sudo -u ${SUDO_USER:-$USER} flatpak install flathub com.github.tchx84.Flatseal --assumeyes
}

# if flatpak is not found
command -v flatpak >/dev/null 2>&1 || {
    echo "Error: flatpak not found; you need to manually install Flatseal;"
}
