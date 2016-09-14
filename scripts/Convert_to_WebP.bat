@echo off
REM A short script to convert images to lossless WebP. Download the WebP tools here: https://developers.google.com/speed/webp/download
REM To auto-delete the original files after the conversion, uncomment the 2 lines below (line 7 and 9).

if exist C:\Doki_Tools\bin set PATH=%PATH%;C:\Doki_Tools\bin

:loop
echo Saving file "%~n1.webp"
REM set input="%1"
cwebp -quiet -lossless -q 100 -m 6 -metadata icc "%~1" -o "%~n1.webp"
REM del "%input%"
shift
if not "%~1"=="" goto :loop

REM pause