:: ffa.bat 2016-08-28
:: Basic batch template for ffmpeg command line, Redmond classic style
:: No error handling whatsoever
:: If you don't understand it don't use it
:: Drag and Drop valid files and folders onto this batch file to execute
@echo off
SETLOCAL
SET "Container=mkv"
:hugly
if "%~1" EQU "" goto mugly
SET "FFREPORT=file=%~n1%~x1.%container%.log:level=32"
ffmpeg -y -hwaccel d3d11va -i "%~1" -af aformat=channel_layouts="7.1|6.1|5.1|stereo" -mapping_family 1 -map 0 libvpx-vp9 -pix_fmt yuv420p10le -b:v 0 -crf 15 -pass 1 -speed 4 -deadline best -row-mt 1 -an -f matroska NUL && ^ffmpeg -hwaccel d3d11va -i "%~1" -af aformat=channel_layouts="7.1|6.1|5.1|stereo" -mapping_family 1 -map 0 -c:v libvpx-vp9 -pix_fmt yuv420p10le -b:v 0 -crf 15 -auto-alt-ref 1 -lag-in-frames 25 -pass 2 -speed 2 -deadline best -row-mt 1 -c:a libopus -c:s copy "%~1.%Container%"
shift
goto hugly
:mugly
SET FFREPORT=
PAUSE