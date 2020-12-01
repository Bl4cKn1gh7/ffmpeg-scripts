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
ffmpeg -y -hwaccel d3d11va -i "%~1" -c:v libx265 -crf 18 -profile:v main10 -preset slow ^
-x265-params "ref=6:bframes=8:rc-lookahead=120:aq-mode=3:aq-strength=0.8:deblock='-1:-1':psy-rd=1.2:rdoq-level=0:psy-rdoq=0:tu-intra-depth=4:tu-inter-depth=4:limit-tu=4:me=3:subme=5" ^
-c:a libopus -c:s copy "%~1.%Container%"
shift
goto hugly
:mugly
SET FFREPORT=
PAUSE