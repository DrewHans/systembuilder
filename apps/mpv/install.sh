#!/usr/bin/env bash

# if flatpak is on system
command -v flatpak >/dev/null 2>&1 && {
    # install through flatpak
    sudo -u ${SUDO_USER:-$USER} flatpak install flathub io.mpv.Mpv --assumeyes
}

# if flatpak is not found
command -v flatpak >/dev/null 2>&1 || {
    echo "MPV install.sh: flatpak not found; skipping install."
}
