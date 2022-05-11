#!/usr/bin/env bash


curl -O https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install ./zoom_amd64.deb --yes
sudo rm -f ./zoom_amd64.deb
