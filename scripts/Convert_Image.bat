@echo off
REM A short script to convert images. 
REM WebP Website: https://developers.google.com/speed/webp/download
REM NConvert Website: http://www.xnview.com/de/nconvert/

if exist C:\Doki_Tools\bin set PATH=%PATH%;C:\Doki_Tools\bin

echo 1) PNG
echo 2) JPEG
echo 3) WebP (lossless)
echo.
set /p target_format=Choose Format: 
echo.


:loop
echo Converting "%~nx1"
if %target_format%==1 nconvert -quiet -out png "%~1"
if %target_format%==2 nconvert -quiet -out jpeg "%~1"
if %target_format%==3 cwebp -quiet -lossless -q 100 -m 6 -metadata icc "%~1" -o "%~n1.webp"
shift
if not "%~1"=="" goto :loop
echo.

REM pause