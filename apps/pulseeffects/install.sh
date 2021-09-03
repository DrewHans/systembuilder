#!/usr/bin/env bash

# if flatpak is on system
command -v flatpak >/dev/null 2>&1 && {
    # install through flatpak
    sudo -u ${SUDO_USER:-$USER} \
        flatpak install flathub com.github.wwmm.pulseeffects
}

# if flatpak is not found
command -v flatpak >/dev/null 2>&1 || {
    echo "PulseEffects install.sh: flatpak not found; skipping install."
}
