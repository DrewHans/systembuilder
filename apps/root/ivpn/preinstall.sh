#!/usr/bin/env bash


# Source: https://www.ivpn.net/apps-linux/#ubuntu

# Add IVPN's GPG key
curl -fsSL https://repo.ivpn.net/stable/ubuntu/generic.gpg | gpg --dearmor > ~/ivpn-archive-keyring.gpg
mv ~/ivpn-archive-keyring.gpg /usr/share/keyrings/ivpn-archive-keyring.gpg


# Add the IVPN repository
curl -fsSL https://repo.ivpn.net/stable/ubuntu/generic.list | tee /etc/apt/sources.list.d/ivpn.list
