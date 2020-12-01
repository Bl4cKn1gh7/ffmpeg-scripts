@echo off
ffmpeg -hwaccel cuvid -c:v h264_cuvid -i %1 -af aformat=channel_layouts="7.1|6.1|5.1|stereo" -mapping_family 1 -map 0 -c:v hevc_nvenc -preset slow -profile:v main10 -rc vbr_hq -rc-lookahead 32 -c:a libopus -c:s copy "%~n1.mkv"

