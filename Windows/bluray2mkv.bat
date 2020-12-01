@echo off
setlocal EnableDelayedExpansion
md nvenc
for %%A in (*.mkv) do (
 ffmpeg -hwaccel auto -c:v h264_cuvid -i "%%~A" -af aformat=channel_layouts="7.1|6.1|5.1|stereo" -mapping_family 1 ^
-map 0 -pix_fmt p010le ^
-c:v hevc_nvenc -profile:v main10 -preset slow -tier high -cq:v 20 -spatial_aq:v 1 -b:v 0 -rc vbr_hq -rc-lookahead 32 ^
-c:s copy ^
-c:a libopus ^
 "nvenc/%%~NA.mkv"
)