workdir=${PWD##*/}
destdir=$HOME/Videos/Encoded/
for i in *.mkv; do ffmpeg -y -hwaccel vaapi -hwaccel_output_format vaapi -vaapi_device /dev/dri/renderD129 -i "$i" -vf 'deinterlace_vaapi=rate=field:auto=1,hwdownload,format=nv12' \
-c:v libvpx-vp9 \
-pix_fmt yuv420p10le \
-profile:v 2 -b:v 0 -g 240 -row-mt 1 -tile-columns 1 -threads 2 -crf 32 -pass 1 -speed 4 \
-an \
-sn \
-f matroska \
/dev/null \
&& \
ffmpeg -hwaccel vaapi -hwaccel_output_format vaapi -vaapi_device /dev/dri/renderD129 -i "$i" -vf 'deinterlace_vaapi=rate=field:auto=1,hwdownload,format=nv12' \
-map 0 -c:v libvpx-vp9 \
-pix_fmt yuv420p10le \
-profile:v 2 -b:v 0 -g 240 -row-mt 1 -tile-columns 1 -threads 2 -crf 32 -auto-alt-ref 1 -lag-in-frames 25 -pass 2 -speed 1 \
-c:a libopus -af "aformat=channel_layouts=7.1|6.1|5.1|stereo" -mapping_family 1 \
-c:s copy \
"$destdir$workdir/${i%.*}.mkv"; done
