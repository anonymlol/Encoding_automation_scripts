@echo off

REM Either drag & drop the folder(s)/file(s) onto the bat or put this into your "send to" folder (Win+R, type "shell:sendto")

REM Install:
REM 1. Download and install node from https://nodejs.org/
REM 2. Open cmd, type 'npm install -g create-torrent'

REM Uninstall:
REM Open cmd, type 'npm uninstall -g create-torrent'

REM Usage: create-torrent <directory OR file> [OPTIONS]
REM -o, --outfile    Output file. If not specified, stdout is used [string]
REM -n, --name       Torrent name [string]
REM --creationDate   Creation date [Date]
REM --comment        Torrent comment [string]
REM --createdBy      Created by client [string]
REM --private        Private torrent? [boolean] [default: false]
REM --pieceLength    Piece length [number] [default: reasonable length]
REM --announce       Tracker url [string] [default: reasonable trackers]
REM --urlList        Web seed url [string]

REM create-torrent path, no need to change
set create-torrent=call create-torrent

echo 1) AniDex + Minglong
echo 2) AniDex
echo 3) Nyaa
echo 4) BakaBT
echo 5) AsianDVDClub

echo.
set /p target_tracker=Choose Tracker: 
echo.

:loop
echo Hashing "%~nx1"
if %target_tracker%==1 %create-torrent% "%~1" --announce "http://anidex.moe:6969/announce" --announce "http://tracker.minglong.org:8080/announce" -o "%~1.torrent"
if %target_tracker%==2 %create-torrent% "%~1" --announce "http://anidex.moe:6969/announce" -o "%~1.torrent"
if %target_tracker%==3 %create-torrent% "%~1" --announce "http://open.nyaatorrents.info:6544/announce" -o "%~1.torrent"
if %target_tracker%==4 %create-torrent% "%~1" --announce "http://tracker.bakabt.me:2710/announce.php" --private -o "%~1.torrent"
if %target_tracker%==5 %create-torrent% "%~1" --announce "http://announce.asiandvdclub.org/" --private -o "%~1.torrent"
shift
if not "%~1"=="" goto :loop

REM pause