#!/bin/bash

for file in *.mkv
do
ffmpeg -y -i "$file" -c:v libvpx-vp9 -row-mt 1 -b:v 0 -crf 32 -pass 1 -speed 4 -an -sn -f matroska /dev/null && ffmpeg -i "$file" -af aformat=channel_layouts="7.1|6.1|5.1|stereo" -mapping_family 1 -map 0 -c:v libvpx-vp9 -auto-alt-ref 1 -lag-in-frames 25 -row-mt 1 -b:v 0 -crf 32 -pass 2 -speed 2 -c:a libopus -c:s copy "${file%.*}-vp9.mkv"
done
