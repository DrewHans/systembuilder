#!/usr/bin/env bash


curl -O https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
sudo apt install ./dropbox_2020.03.04_amd64.deb --yes
sudo rm -f ./dropbox_2020.03.04_amd64.deb
