@echo off

REM Either drag & drop the folder(s)/file(s) onto the bat or put this into your "send to" folder (Win+R, type "shell:sendto")
REM Don't forget to add mktorrent to your path or to adjust its path below.
REM To see the mktorrent options, use "mktorrent -h"

echo 1) AniDex + Minglong
echo 2) AniDex + NFP Tracker
echo 3) AniDex
echo 4) Nyaa
echo 5) BakaBT
echo.
set /p target_tracker=Choose Tracker: 
echo.

:loop
if %target_tracker%==1 mktorrent -a "http://anidex.moe:6969/announce" -a "http://tracker.minglong.org:8080/announce" -l 19 "%~1"
if %target_tracker%==2 mktorrent -a "http://anidex.moe:6969/announce" -a "udp://tot.is:6969/announce" -l 19 "%~1"
if %target_tracker%==3 mktorrent -a "http://anidex.moe:6969/announce" -l 19 "%~1"
if %target_tracker%==4 mktorrent -a "http://open.nyaatorrents.info:6544/announce" -l 19 "%~1"
if %target_tracker%==5 mktorrent -a "http://tracker.bakabt.me:2710/announce.php" -l 19 -p "%~1"

echo.
shift
if not "%~1"=="" goto :loop

REM pause