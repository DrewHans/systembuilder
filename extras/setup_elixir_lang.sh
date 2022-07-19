#!/usr/bin/env bash


echo "Warning: this didn't work on Ubuntu 22.04 when I last tried it"
echo "Press enter to continue:"
read tmpvar


curl -O https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb


if [ ! -f "erlang-solutions_2.0_all.deb" ]; then
    echo "Failed to download erlang-solutions_2.0_all.deb file; aborting"
    exit 1
fi

sudo dpkg -i erlang-solutions_2.0_all.deb || {
    echo "Failed to install erlang-solutions_2.0_all.deb; aborting"
    exit 1
}

sudo apt update

sudo apt install esl-erlang elixir

