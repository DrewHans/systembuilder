#!/usr/bin/env bash


# Uninstall docker
sudo apt purge docker-ce docker-ce-cli containerd.io docker-compose-plugin --yes

# Delete all images, containers, and volumes
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
