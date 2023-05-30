#!/usr/bin/env bash


sudo apt update

# install newest python3 and pip3 using apt
sudo apt install python3 python3-pip

echo "python version installed:"
python --version
echo ""

echo "pip3 version installed:"
pip3 --version
echo ""

# upgrade pip to newest pip version
pip3 install --upgrade pip

# install pipx so we can install python apps in isolated environments
python3 -m pip install --user pipx
python3 -m pipx ensurepath

# upgrade pipx to newest version
#python3 -m pip install --user --upgrade pipx

echo "pip packages installed:"
pip list
echo ""

echo "pipx packages installed:"
pipx list
echo ""

echo "Finished"
