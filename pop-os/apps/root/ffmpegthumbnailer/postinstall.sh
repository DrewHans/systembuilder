#!/usr/bin/env bash


# replace totem-video-thumbnailer call with ffmpegthumbnailer
patternMatch="^Exec=\/usr\/bin\/totem-video-thumbnailer -s %s %u %o$"
replacementText="Exec=ffmpegthumbnailer -s %s -i %i -o %o -c png -f"
sedPattern="/$patternMatch/c\\$replacementText"

sed -i "$sedPattern" /usr/share/thumbnailers/totem.thumbnailer
