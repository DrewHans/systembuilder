#!/usr/bin/env bash

sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp

sudo chmod a+rx /usr/local/bin/yt-dlp

# if yt-dlp is not already installed
command -v yt-dlp >/dev/null 2>&1 || {
    sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp
}