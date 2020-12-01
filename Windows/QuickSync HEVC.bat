:: Drag and Drop valid files and folders onto this batch file to execute
@echo off
setlocal EnableDelayedExpansion
md qsv
for %%A in (*.mkv) do (
 ffmpeg -hwaccel qsv -c:v h264_qsv -i "%%~A" -af aformat=channel_layouts="7.1|6.1|5.1|stereo" -mapping_family 1 ^
-map 0 ^
-c:v hevc_qsv -preset veryslow -profile:v main -b:v 12M -rdo 1 -adaptive_i 1 -adaptive_b 1 -look_ahead 1 ^
-c:a libopus ^
-c:s copy ^
 "qsv/%%~NA.mkv"
)