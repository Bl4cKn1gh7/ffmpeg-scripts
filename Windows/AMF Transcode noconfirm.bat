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
ffmpeg -hwaccel d3d11va -hwaccel_output_format d3d11 -i "%~1" -af aformat=channel_layouts="7.1|6.1|5.1|stereo" -mapping_family 1 -map 0 -c:v h264_amf -rc cqp -profile:v high -quality quality -c:a libopus -c:s copy "%~1.%Container%"
shift
goto hugly
:mugly
SET FFREPORT=
PAUSE