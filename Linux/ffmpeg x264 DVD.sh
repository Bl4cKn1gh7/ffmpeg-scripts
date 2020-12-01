#!/bin/bash

for file in *.mkv
do
ffmpeg -y -hwaccel vaapi -vaapi_device /dev/dri/renderD129 -hwaccel_output_format vaapi \
-i "$file" -vf 'deinterlace_vaapi=rate=field:auto=1,format=nv12|vaapi,hwupload' -c:v h264_vaapi -qp 19 -bf 4 -pass 1 \
-an \
-sn \
-f matroska "/dev/null" \
&& \
ffmpeg -hwaccel vaapi -vaapi_device /dev/dri/renderD129 -hwaccel_output_format vaapi \
-i "$file" -vf 'deinterlace_vaapi=rate=field:auto=1,format=nv12|vaapi,hwupload' -c:v h264_vaapi -qp 19 -bf 4 -pass 2 \
-c:a aac \
-c:s copy \
"${file%.*}_x264-qp19.mkv"
done
