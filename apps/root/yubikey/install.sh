#!/usr/bin/env bash

apt install \
    yubikey-manager \
    yubikey-personalization-gui \
    libpam-yubico \
    libpam-u2f \
    --yes

# https://support.yubico.com/hc/en-us/articles/360016649039-Enabling-the-Yubico-PPA-on-Ubuntu
# https://support.yubico.com/hc/en-us/articles/360016649099-Ubuntu-Linux-Login-Guide-U2F
# if using cryptdisk, remember to move ~/.config/Yubico/u2f_keys file to /etc/Yubico/u2f_keys
