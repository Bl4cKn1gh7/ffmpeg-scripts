@echo off
setlocal EnableDelayedExpansion
for %%A in (*.flac) do (
 opusenc "%%~A" "%%~NA.opus"
)