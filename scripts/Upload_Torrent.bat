@echo off

REM This script uploads your torrents to nyaa.si

if exist C:\Doki_Tools\scripts set PATH=%PATH%;C:\Doki_Tools\scripts

echo 1) Doki
echo 2) NFP
echo.

set /p account_selection=Select Account: 
echo.

REM Enter/Change group details here
if %account_selection%==1 (
    set user=Doki
    set password=
    set info=https://doki.co
    set description=[#doki@irc.rizon.net]^(irc://irc.rizon.net/doki^)
)
if %account_selection%==2 (
    set user=NFP
    set password=
    set info=http:/nfp.moe
    set description=[#nfp@irc.rizon.net]^(irc://irc.rizon.net/nfp^)
)

echo 1) Anime - English
echo 2) Anime - AMV
echo 3) Audio - Lossless
echo 4) Audio - Lossy
echo 5) Literature - English-translated 
echo 6) Live Action - English-translated 
echo.

set /p category_selection=Select Category: 
echo.

set /p hidden_torrent=Hidden Torrent? (y/n) 
if /I "%hidden_torrent%"=="y" (set hidden=--hidden)
)
echo.

set /p complete_torrent=Complete Torrent? (y/n) 
if /I "%complete_torrent%"=="y" (set complete=--complete)
echo.

if %category_selection%==1 set nyaa_cat=1_2
if %category_selection%==2 set nyaa_cat=1_1
if %category_selection%==3 set nyaa_cat=2_1
if %category_selection%==4 set nyaa_cat=2_2
if %category_selection%==5 set nyaa_cat=3_1
if %category_selection%==6 set nyaa_cat=4_1

:loop
API_Upload_Nyaa.py --user=%user% --password=%password% --category=%nyaa_cat% --information=%info% --description=%description% %hidden% %complete% --trusted "%~1"
echo.
shift
if not "%~1"=="" goto :loop

pause