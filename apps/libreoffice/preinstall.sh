#!/usr/bin/env bash

# remove outdated libreoffice (if installed through apt)
sudo apt remove --purge libreoffice libreoffice-\* --yes

# note: apt clean && apt autoremove should be run to remove unused dependencies
