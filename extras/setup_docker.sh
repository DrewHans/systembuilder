#!/usr/bin/env bash


# Uninstall old versions
sudo apt remove docker docker-engine docker.io containerd runc


# Set up the repository
sudo apt install ca-certificates curl gnupg lsb-release --yes

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


# Install Docker Engine
sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin --yes


# Verify Installation was successful
sudo docker run hello-world

# source: https://docs.docker.com/engine/install/debian/