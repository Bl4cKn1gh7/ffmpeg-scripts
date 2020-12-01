workdir=${PWD##*/}
destdir=/home/jack/Videos/Encoded/

for i in *.mkv; do ffmpeg -n -i "$i" -vsync 2 -vf crop=720:360:0:50 \
-map '0:v?' \
-map '0:a?' \
-map '0:s?' \
-map '0:d?' \
-map '0:t?' \
-c:v:0 libx264 \
-crf 18 -preset medium -x264-params \
ref=16:bframes=16:b-adapt=2:me=umh:subme=10:partitions=all:trellis=2:rc-lookahead=60:aq-mode=3 \
-c:a aac \
-c:s copy \
-c:d copy \
-c:t copy -map_metadata 0 \
"$destdir/${i%.*}.mkv"; done
