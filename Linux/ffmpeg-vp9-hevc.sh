#!/bin/bash
for i in *.mkv;
 do ffmpeg -hwaccel auto -i "$i" -map 0 -threads 8 \
	-c:v libvpx-vp9 -pix_fmt yuv420p10le -color_primaries bt709 -color_trc bt709 -colorspace bt709 \
	-profile:v 2 -b:v 0 -row-mt 1 -crf 30 -pass 1 -speed 4 \
	-an \
	-sn \
	-f matroska \
	/dev/null 2> libvp9-err.txt \
	&& \
	ffmpeg -hwaccel auto -i "$i" -map 0 -threads 8 \
	-c:v libvpx-vp9 -pix_fmt yuv420p10le -color_primaries bt709 -color_trc bt709 -colorspace bt709 \
	-profile:v 2 -b:v 0 -row-mt 1 -crf 30 -auto-alt-ref 1 -lag-in-frames 25 -pass 2 -speed 2 \
	-c:v libx265 -pix_fmt yuv420p10le -color_primaries bt709 -color_trc bt709 -colorspace bt709 \
	-preset slow -profile:v main10 -crf 28 \
	-c:a libopus -af "aformat=channel_layouts=7.1|6.1|5.1|stereo" -mapping_family 1 \
	-c:a aac \
	-c:s copy \
	"${i%.*}-VP9.2-x265-10-aac-opus.mkv"
;done
