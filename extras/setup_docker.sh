#!/usr/bin/env bash


command -v docker >/dev/null 2>&1 && {
	echo "Uninstalling old version of docker"
	sudo apt remove docker --yes
	sudo apt remove docker-engine --yes
	sudo apt remove docker.io --yes
	sudo apt remove containerd --yes
	sudo apt remove runc --yes
}


# Set up the repository
sudo apt install ca-certificates curl gnupg lsb-release --yes

if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
	sudo mkdir -p /etc/apt/keyrings

	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

	sudo chmod a+r /etc/apt/keyrings/docker.gpg
fi

if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bullseye stable" \
	| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi


# Install Docker Engine
sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin --yes


# Verify Installation was successful
sudo docker run hello-world

# source: https://docs.docker.com/engine/install/debian/
