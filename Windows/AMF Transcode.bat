@echo off
for %%a in (%*) do ffmpeg -hwaccel d3d11va -hwaccel_output_format d3d11 -i [%%a] -af aformat=channel_layouts="7.1|6.1|5.1|stereo" -mapping_family 1 -map 0 -c:v h264_amf -rc cqp -profile high -quality quality -c:a libopus -c:s copy "%~n1.mkv"
pause