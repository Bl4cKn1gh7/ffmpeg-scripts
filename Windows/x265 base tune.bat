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
ffmpeg -y -hwaccel d3d11va -i "%~1" -map 0 -af aformat=channel_layouts="7.1|6.1|5.1|stereo" -mapping_family 1 -c:v libx265 -crf 19 -profile:v main10 -preset slow ^
-x265-params "ctu=32:max-tu-size=8:qg-size=16:ref=6:bframes=8:keyint=480:splitrd-skip:no-strong-intra-smoothing:no-sao:rect:amp:rd-refine:ipratio=1.38:pbratio=1.28:cbqpoffs=-3:crqpoffs=-3:rc-lookahead=240:aq-mode=3:aq-strength=1.0:deblock='-1:-1':psy-rd=1.2:rdoq-level=0:psy-rdoq=0:tu-intra-depth=4:tu-inter-depth=4:limit-tu=4:limit-refs=3:max-merge=2:me=3:subme=5:merange=44" ^
-c:a libopus -c:s copy "%~1.%Container%"
shift
goto hugly
:mugly
SET FFREPORT=
PAUSE