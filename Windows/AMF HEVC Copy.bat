:: Drag and Drop valid files and folders onto this batch file to execute
@echo off
setlocal EnableDelayedExpansion
md vce
for %%A in (*.mkv) do (
 ffmpeg -hwaccel d3d11va -i "%%~A" ^
-map 0 ^
-c:v hevc_amf -quality quality -rc cqp -qp_i 19 -qp_p 19 ^
-c:a copy ^
-c:s copy ^
 "vce/%%~NA.mkv"
)