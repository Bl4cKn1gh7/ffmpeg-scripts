workdir=${PWD##*/}
destdir=/home/jack/Videos/Encoded/

for i in *.mkv; do ffmpeg -n -i "$i" -vsync 2  -vf crop=1864:1048:28:16  \
-map '0:v?' \
-map '0:a?' \
-map '0:s?' \
-map '0:d?' \
-map '0:t?' \
-c:v:0 libx265 \
-pix_fmt yuv420p10le -crf 18 -preset slow -x265-params \
ref=6:bframes=16:rc-lookahead=60:hist-scenecut=1:scenecut-aware-qp=1:psy-rd=1.5:psy-rdoq=2:aq-mode=3 \
-c:a libopus -af "aformat=channel_layouts=7.1|6.1|5.1|stereo" -mapping_family 1 \
-c:s copy \
-c:d copy \
-c:v:1 copy \
-c:t copy -map_metadata 0 \
"$destdir/${i%.*}.mkv"; done
