@echo off
for %%A in ("%CD%") do set "folderName=%%~nxA"
for %%A in ("%~dp0..") do set "Showname=%%~nxA"
for %%A in (*.mkv) do set "mkvSource=%%~nxA"

REM x264 settings
set Enc_480=x264 --level 4.1 --colormatrix bt709 --preset veryslow --crf 15.0 --log-level none --output "480.mkv" "480.avs"
set Enc_720=x264-10bit --level 5.1 --preset veryslow --crf 15.0 --log-level none --output "720.mkv" "720.avs"
set Enc_1080=x264-10bit --level 5.1 --preset veryslow --crf 18.0 --log-level none --output "1080.mkv" "1080.avs"

REM eac3to settings
set audio_AAC=eac3to src.m2ts 2: audio.mp4 -quality=0.6
set audio_FLAC=eac3to src.m2ts 2: audio.flac -down16

REM Set audio for each resolution (muxing). Extensions only.
set audio_480=mp4
set audio_720=mp4
set audio_1080=flac

REM Set your desired filename tags.
set Tags_480=(848x480 BD AAC)
set Tags_720=(1280x720 Hi10P BD AAC)
set Tags_1080=(1920x1080 Hi10P BD FLAC)

REM Track-names when muxing.
set video_track_name_480=AVC
set video_track_name_720=AVC
set video_track_name_1080=AVC

set audio_track_name_480=AAC
set audio_track_name_720=AAC
set audio_track_name_1080=FLAC

REM Indexing settings.
set DGAVCIndex=DGAVCIndex -i "src.m2ts" -o "src.dga" -h
set DGIndexNV=DGIndexNV -i "src.m2ts" -o "src.dgi" -h

REM Set your frameserver here. Supported ones are listed above.
set Frameserver=%DGIndexNV%

REM Leave this if the indexer is in your path. If it isn't, modify the string extraction to return the name of the indexer. Example: start position --> 0,10 <-- amount of letters.
if %Frameserver:~0,10%==DGAVCIndex set indexFile="src.dga"
if %Frameserver:~0,9%==DGIndexNV set indexFile="src.dgi"

REM All m2ts files will be renamed to this. You can disable it by switching "renameSource" to false.
set renameSource=true
set sourceName=src

REM Copy/paste avs scripts from the first folder to the others (only if they don't already exist). You can disable it by switching "copyScripts" to false.
REM set copyScripts=true
REM set avsFolder=Ep 01

if %folderName:~0,2%==Ep (
	set epNumber=%folderName:~-2,2%
)	else (
	set epNumber=%folderName%
)

set Mux_480=mkvmerge -o "%Showname% - %epNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_480%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_480%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_480%" ")" "--track-order" "0:0,1:0"
set Mux_720=mkvmerge -o "%Showname% - %epNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_720%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_720%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_720%" ")" "--track-order" "0:0,1:0"
set Mux_1080=mkvmerge -o "%Showname% - %epNumber% %Tags_1080%.mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_1080%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_1080%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_1080%" ")" "--track-order" "0:0,1:0"

@echo.
@echo --------------------------------%Showname% %epNumber%--------------------------------
@echo.

if exist *.m2ts (
	REM if %copyScripts%==true (
		REM if not exist "480.avs" xcopy "%~dp0..%avsFolder%\480.avs" && @echo.
		REM if not exist "720.avs" xcopy "%~dp0..%avsFolder%\720.avs" && @echo.
		REM if not exist "1080.avs" xcopy "%~dp0..%avsFolder%\1080.avs" && @echo.
	REM )
	if %renameSource%==true (if not *.m2ts==src.m2ts rename *.m2ts %sourceName%.m2ts)
	if not exist %indexFile% @echo Indexing %Showname% - %epNumber% && %Frameserver% && @echo Indexing done && @echo.
	if not exist "audio.mp4" @echo Encoding %Showname% - %epNumber% AAC && %audio_AAC% && @echo.
	if not exist "audio.flac" @echo Encoding %Showname% - %epNumber% FLAC && %audio_FLAC% && @echo.
	if exist "480.avs" (
		if not exist "480.mkv" @echo Encoding %Showname% - %epNumber% 480p && %Enc_480% && @echo.
		if not exist "%Showname% - %epNumber% %Tags_480%.mkv" @echo Muxing %Showname% - %epNumber% 480p && %Mux_480% && @echo. && @echo.
	)
	if exist "720.avs" (
		if not exist "720.mkv" @echo Encoding %Showname% - %epNumber% 720p && %Enc_720% && @echo.
		if not exist "%Showname% - %epNumber% %Tags_720%.mkv" @echo Muxing %Showname% - %epNumber% 720p && %Mux_720% && @echo. && @echo.
	)
	if exist "1080.avs" (
		if not exist "1080.mkv" @echo Encoding %Showname% - %epNumber% 1080p && %Enc_1080% && @echo.
		if not exist "%Showname% - %epNumber% %Tags_1080%.mkv" @echo Muxing %Showname% - %epNumber% 1080p && %Mux_1080% && @echo. && @echo.
	)
)

REM pause