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
ffmpeg -hwaccel auto ^
-i "%~1" ^
-map 0:0 -pix_fmt p010le ^
-c:v hevc_nvenc -preset slow -profile:v main10 -tier high -rc:v vbr_hq -spatial_aq:v 1 -rc-lookahead 32 -pass 1 ^
-an ^
-sn ^
-f matroska NUL ^
&& ^
ffmpeg -hwaccel auto ^
-i "%~1" -pix_fmt p010le ^
-map 0 ^
-c:v hevc_nvenc -preset slow -profile:v main10 -tier high -rc:v vbr_hq -spatial_aq:v 1 -rc-lookahead 32 -pass 2 ^
-c:a libopus ^
-c:s copy ^
"%~1.%Container%"
shift
goto hugly
:mugly
SET FFREPORT=
PAUSE
