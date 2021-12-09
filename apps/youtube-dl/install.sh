#!/usr/bin/env bash

# if youtube-dl is not already installed
command -v youtube-dl >/dev/null 2>&1 || {
    sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl
}