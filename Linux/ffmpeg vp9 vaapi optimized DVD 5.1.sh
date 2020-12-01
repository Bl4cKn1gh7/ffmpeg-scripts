#!/bin/bash

for file in *.mkv
do
ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD129 -y -i "$file" -c:v libvpx-vp9 -pix_fmt yuv420p10le -deadline best -row-mt 1 -b:v 0 -crf 30 -pass 1 -speed 4 -an -f matroska /dev/null && ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD129 -i "$file" -map 0:0 -map 0:1 -map 0:2 -c:v libvpx-vp9 -pix_fmt yuv420p10le -auto-alt-ref 1 -lag-in-frames 25 -deadline best -row-mt 1 -b:v 0 -crf 30 -pass 2 -speed 2 -c:a libopus -af "channelmap=channel_layout=5.1" "${file%.*}_vp9-10b.mkv"
done
