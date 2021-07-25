#!/usr/bin/env bash

# if flatpak is on system
command -v flatpak >/dev/null 2>&1 && {
    # install through flatpak
    sudo -u ${SUDO_USER:-$USER} \
        flatpak install flathub org.videolan.VLC
}

# if flatpak is not found
command -v flatpak >/dev/null 2>&1 || {
    # install through apt
    sudo apt install vlc --yes
}
