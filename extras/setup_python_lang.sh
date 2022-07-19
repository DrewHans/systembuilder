#!/usr/bin/env bash


# Optional step: enable deadsnakes ppa
# get access to newer Python releases not available in default package manager
# sudo add-apt-repository ppa:deadsnakes/ppa --yes --no-update

sudo apt update

# install newest python3 and pip3 using apt
sudo apt install python3 python3-pip

command -v python >/dev/null 2>&1 && {
    echo "python version installed:"
    python --version
    echo ""
}

command -v pip3 >/dev/null 2>&1 && {
    echo "pip3 version installed:"
    pip3 --version
    echo ""
}

# upgrade pip to newest pip version
pip3 install --upgrade pip

# install venv so we can setup virtual python environments
sudo pip3 install virtualenv

echo "pip packages installed:"
pip list
echo ""

echo "Finished"
