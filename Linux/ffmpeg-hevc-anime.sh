workdir=${PWD##*/}
destdir=/home/jack/Videos/Encoded/

for i in *.mkv; do ffmpeg -n -i "$i" -vsync 2 \
-map 0 -map_metadata 0 -c:v libx265 \
-pix_fmt yuv420p10le \
-crf 18 -preset slow -x265-params \
ref=6:bframes=8:rc-lookahead=60:hist-scenecut=1:scenecut-aware-qp=1:psy-rd=1.5:psy-rdoq=2:aq-mode=3 \
-c:a libopus -af "aformat=channel_layouts=7.1|6.1|5.1|stereo" -mapping_family 1 \
-c:s copy \
"$destdir/${i%.*}.mkv"; done
