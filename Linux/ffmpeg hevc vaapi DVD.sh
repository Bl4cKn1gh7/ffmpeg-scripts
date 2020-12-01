workdir=${PWD##*/}
destdir=$HOME/Videos/Encoded/
for i in *.mkv; do ffmpeg -hwaccel vaapi -hwaccel_output_format vaapi -vaapi_device /dev/dri/renderD128 -i "$i" -vf 'deinterlace_vaapi=rate=field:auto=1,hwdownload,format=nv12' \
-map 0 -c:v libx265 \
-pix_fmt yuv420p10le \
-crf 18 -preset slow -x265-params \
"ref=6:bframes=8:rc-lookahead=120:aq-mode=3:aq-strength=0.8:deblock='-1:-1':psy-rd=1.2:rdoq-level=0:psy-rdoq=0:tu-intra-depth=4:tu-inter-depth=4:limit-tu=4:me=3:subme=5" \
-c:a libopus -af "aformat=channel_layouts=7.1|6.1|5.1|stereo" -mapping_family 1 \
-c:s copy \
"$destdir$workdir/${i%.*}.mkv"; done
