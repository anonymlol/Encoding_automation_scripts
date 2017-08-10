@echo off

REM This script uploads your torrents to AniDex, Nyaa.si and TokyoTosho
REM To enter your login details and settings, go to C:\Doki_Tools\settings\API_Settings.txt

if exist C:\Doki_Tools\scripts set PATH=%PATH%;C:\Doki_Tools\scripts
for /f "delims== tokens=1,2" %%G in (C:\Doki_Tools\settings\API_Settings.txt) do set %%G=%%H

REM AniDex Account Details
set anidex_api_key=%anidex_api_key%
set group_id=%group_id%

REM TokyoTosho API (off=0, on=1)
set tokyotosho_api=%tokyotosho_api%

REM Nyaa Account Details
set user=%nyaa_username%
set password=%nyaa_password%
set info=%nyaa_info%
set description=%nyaa_description%

echo Non-Hentai
echo 1) Anime
echo 2) Manga
echo 3) Live Action
echo.
echo Hentai
echo 4) Anime
echo 5) Manga
echo 6) Doujinshi
echo.

set /p category_selection=Select Category: 
echo.

set /p hidden_torrent=Hidden Torrent? (y/n) 
if /I "%hidden_torrent%"=="y" (set hidden=--hidden && set private=-F "private=1")

echo.

set /p complete_torrent=Complete Torrent? (y/n) 
if /I "%complete_torrent%"=="y" (set complete=--complete && set batch=-F "batch=1")
echo.

if %category_selection%==1 set nyaa_cat=1_2 && set subcat_id=1
if %category_selection%==2 set nyaa_cat=3_1 && set subcat_id=7
if %category_selection%==3 set nyaa_cat=4_1 && set subcat_id=4
if %category_selection%==4 (
    set nyaa_cat=1_1
    set sukebei=--sukebei
    set subcat_id=1
    set hentai=-F "hentai=1"
)
if %category_selection%==5 (
    set nyaa_cat=1_4
    set sukebei=--sukebei
    set subcat_id=7
    set hentai=-F "hentai=1"
)
if %category_selection%==6 (
    set nyaa_cat=1_2
    set sukebei=--sukebei
    set subcat_id=7
    set hentai=-F "hentai=1"
)

if %tokyotosho_api%==0 echo TokyoTosho API Off
if %tokyotosho_api%==1 echo TokyoTosho API On
echo.

:loop
API_Upload_Nyaa.py --user=%user% --password=%password% --category=%nyaa_cat% --information=%info% --description=%description% %hidden% %complete% %sukebei% --trusted "%~1"
echo.
curl -F "subcat_id=%subcat_id%" -F "file=@%~1" -F "group_id=%group_id%" -F "lang_id=1" -F "api_key=%anidex_api_key%" -F "tt_api=%tokyotosho_api%" %private% %batch% %hentai% -k https://anidex.info/api/
echo.
shift
if not "%~1"=="" goto :loop

pause
