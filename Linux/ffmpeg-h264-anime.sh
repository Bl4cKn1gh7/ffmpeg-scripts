workdir=${PWD##*/}
destdir=/home/jack/Videos/Encoded/

for i in *.mkv; do ffmpeg -n -i "$i" -vsync 2 \
-map 0 -map_metadata 0 -c:v libx264 \
-crf 18 -preset medium -x264-params \
ref=6:bframes=16:rc-lookahead=60:psy-rd=1.5:aq-mode=3 \
-c:a aac \
-c:s copy \
-c:d copy \
-c:t copy \
"$destdir/${i%.*}.mkv"; done
