@echo off
echo /d %~dp0
cd /d %~dp0
FFMPEG  -i  %1 -c:v libx264 -strict -2 -s 1280x720 -b 1000k %2
exit