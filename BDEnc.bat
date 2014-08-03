@echo off

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

REM Indexing settings.
set DGAVCIndex=DGAVCIndex -i "src.m2ts" -o "src.dga" -h
set DGIndexNV=DGIndexNV -i "src.m2ts" -o "src.dgi" -h

REM Set your frameserver here. Supported ones are listed above.
set Frameserver=%DGIndexNV%

REM Leave this if the indexer is in your path. If it isn't, modify the string extraction to return the name of the indexer. Example: start position --> 0,10 <-- amount of letters.
if %Frameserver:~0,10%==DGAVCIndex set indexFile="src.dga"
if %Frameserver:~0,9%==DGIndexNV set indexFile="src.dgi"

REM Max number of episodes. Doesn't need to be changed unless you need more.
set Episodes=100

REM All m2ts files will be renamed to this. You can disable it by switching it to false.
set renameSource=true
set sourceName=src

for %%A in ("%CD%") do set "folderName=%%~nxA"

@echo.
@echo Show: %folderName%
@echo.

set folderCount=0
:loop
set /a folderCount=folderCount+1

if %folderCount% LSS 10 set episodeNumber=0%folderCount%
if %folderCount% GEQ 10 set episodeNumber=%folderCount%

set MuxEp_480=mkvmerge -o "%folderName% - %episodeNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_480%" ")" "--track-order" "0:0,1:0"
set MuxEp_720=mkvmerge -o "%folderName% - %episodeNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_720%" ")" "--track-order" "0:0,1:0"
set MuxEp_1080=mkvmerge -o "%folderName% - %episodeNumber% %Tags_1080%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_1080%" ")" "--track-order" "0:0,1:0"
set MuxNCED_480=mkvmerge -o "%folderName% - NCED %episodeNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_480%" ")" "--track-order" "0:0,1:0"
set MuxNCED_720=mkvmerge -o "%folderName% - NCED %episodeNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_720%" ")" "--track-order" "0:0,1:0"
set MuxNCED_1080=mkvmerge -o "%folderName% - NCED %episodeNumber% %Tags_1080%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_1080%" ")" "--track-order" "0:0,1:0"
set MuxNCOP_480=mkvmerge -o "%folderName% - NCOP %episodeNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_480%" ")" "--track-order" "0:0,1:0"
set MuxNCOP_720=mkvmerge -o "%folderName% - NCOP %episodeNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_720%" ")" "--track-order" "0:0,1:0"
set MuxNCOP_1080=mkvmerge -o "%folderName% - NCOP %episodeNumber% %Tags_1080%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_1080%" ")" "--track-order" "0:0,1:0"
set MuxSpecial_480=mkvmerge -o "%folderName% - Special %episodeNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_480%" ")" "--track-order" "0:0,1:0"
set MuxSpecial_720=mkvmerge -o "%folderName% - Special %episodeNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_720%" ")" "--track-order" "0:0,1:0"
set MuxSpecial_1080=mkvmerge -o "%folderName% - Special %episodeNumber% %Tags_1080%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_1080%" ")" "--track-order" "0:0,1:0"
set MuxOVA_480=mkvmerge -o "%folderName% - OVA %episodeNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_480%" ")" "--track-order" "0:0,1:0"
set MuxOVA_720=mkvmerge -o "%folderName% - OVA %episodeNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_720%" ")" "--track-order" "0:0,1:0"
set MuxOVA_1080=mkvmerge -o "%folderName% - OVA %episodeNumber% %Tags_1080%.mkv"  "--quiet" "--language" "0:jpn" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--language" "0:jpn" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_1080%" ")" "--track-order" "0:0,1:0"

if exist "Ep %episodeNumber%" (
	@echo -----------------------------------Episode %episodeNumber%-----------------------------------
	@echo.
	cd "Ep %episodeNumber%"
	if exist *.m2ts (
		if %renameSource%==true (if not *.m2ts==src.m2ts rename *.m2ts %sourceName%.m2ts)
		if not exist %indexFile% @echo Indexing %folderName% - %episodeNumber% && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" @echo Encoding %folderName% - %episodeNumber% AAC && %audio_AAC% && @echo.
		if not exist "audio.flac" @echo Encoding %folderName% - %episodeNumber% FLAC && %audio_FLAC% && @echo.
		if exist "480.avs" (
			if not exist "480.mkv" @echo Encoding %folderName% - %episodeNumber% 480p && %Enc_480% && @echo.
			if not exist "%folderName% - %episodeNumber% %Tags_480%.mkv" @echo Muxing %folderName% - %episodeNumber% 480p && %MuxEp_480% && @echo. && @echo.
		)
		if exist "720.avs" (
			if not exist "720.mkv" @echo Encoding %folderName% - %episodeNumber% 720p && %Enc_720% && @echo.
			if not exist "%folderName% - %episodeNumber% %Tags_720%.mkv" @echo Muxing %folderName% - %episodeNumber% 720p && %MuxEp_720% && @echo. && @echo.
		)
		if exist "1080.avs" (
			if not exist "1080.mkv" @echo Encoding %folderName% - %episodeNumber% 1080p && %Enc_1080% && @echo.
			if not exist "%folderName% - %episodeNumber% %Tags_1080%.mkv" @echo Muxing %folderName% - %episodeNumber% 1080p && %MuxEp_1080% && @echo. && @echo.
		)
	)
	@echo.
	cd..
)
if exist "NCED %episodeNumber%" (
	@echo -----------------------------------NCED %episodeNumber%-----------------------------------
	@echo.
	cd "NCED %episodeNumber%"
	if exist *.m2ts (
		if %renameSource%==true (if not *.m2ts==src.m2ts rename *.m2ts %sourceName%.m2ts)
		if not exist %indexFile% @echo Indexing %folderName% - NCED %episodeNumber% && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" @echo Encoding %folderName% - NCED %episodeNumber% AAC && %audio_AAC% && @echo.
		if not exist "audio.flac" @echo Encoding %folderName% - NCED %episodeNumber% FLAC && %audio_FLAC% && @echo.
		if exist "480.avs" (
			if not exist "480.mkv" @echo Encoding %folderName% - NCED %episodeNumber% 480p && %Enc_480% && @echo.
			if not exist "%folderName% - NCED %episodeNumber% %Tags_480%.mkv" @echo Muxing %folderName% - NCED %episodeNumber% 480p && %MuxNCED_480% && @echo. && @echo.
		)
		if exist "720.avs" (
			if not exist "720.mkv" @echo Encoding %folderName% - NCED %episodeNumber% 720p && %Enc_720% && @echo.
			if not exist "%folderName% - NCED %episodeNumber% %Tags_720%.mkv" @echo Muxing %folderName% - NCED %episodeNumber% 720p && %MuxNCED_720% && @echo. && @echo.
		)
		if exist "1080.avs" (
			if not exist "1080.mkv" @echo Encoding %folderName% - NCED %episodeNumber% 1080p && %Enc_1080% && @echo.
			if not exist "%folderName% - NCED %episodeNumber% %Tags_1080%.mkv" @echo Muxing %folderName% - NCED %episodeNumber% 1080p && %MuxNCED_1080% && @echo. && @echo.
		)
	)
	@echo.
	cd..
)
if exist "NCOP %episodeNumber%" (
	@echo -----------------------------------NCOP %episodeNumber%-----------------------------------
	@echo.
	cd "NCOP %episodeNumber%"
	if exist *.m2ts (
		if %renameSource%==true (if not *.m2ts==src.m2ts rename *.m2ts %sourceName%.m2ts)
		if not exist %indexFile% @echo Indexing %folderName% - NCOP %episodeNumber% && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" @echo Encoding %folderName% - NCOP %episodeNumber% AAC && %audio_AAC% && @echo.
		if not exist "audio.flac" @echo Encoding %folderName% - NCOP %episodeNumber% FLAC && %audio_FLAC% && @echo.
		if exist "480.avs" (
			if not exist "480.mkv" @echo Encoding %folderName% - NCOP %episodeNumber% 480p && %Enc_480% && @echo.
			if not exist "%folderName% - NCOP %episodeNumber% %Tags_480%.mkv" @echo Muxing %folderName% - NCOP %episodeNumber% 480p && %MuxNCOP_480% && @echo. && @echo.
		)
		if exist "720.avs" (
			if not exist "720.mkv" @echo Encoding %folderName% - NCOP %episodeNumber% 720p && %Enc_720% && @echo.
			if not exist "%folderName% - NCOP %episodeNumber% %Tags_720%.mkv" @echo Muxing %folderName% - NCOP %episodeNumber% 720p && %MuxNCOP_720% && @echo. && @echo.
		)
		if exist "1080.avs" (
			if not exist "1080.mkv" @echo Encoding %folderName% - NCOP %episodeNumber% 1080p && %Enc_1080% && @echo.
			if not exist "%folderName% - NCOP %episodeNumber% %Tags_1080%.mkv" @echo Muxing %folderName% - NCOP %episodeNumber% 1080p && %MuxNCOP_1080% && @echo. && @echo.
		)		
	)
	@echo.
	cd..
)
if exist "Special %episodeNumber%" (
	@echo -----------------------------------Special %episodeNumber%-----------------------------------
	@echo.
	cd "Special %episodeNumber%"
	if exist *.m2ts (
		if %renameSource%==true (if not *.m2ts==src.m2ts rename *.m2ts %sourceName%.m2ts)
		if not exist %indexFile% @echo Indexing %folderName% - Special %episodeNumber% && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" @echo Encoding %folderName% - Special %episodeNumber% AAC && %audio_AAC% && @echo.
		if not exist "audio.flac" @echo Encoding %folderName% - Special %episodeNumber% FLAC && %audio_FLAC% && @echo.
		if exist "480.avs" (
			if not exist "480.mkv" @echo Encoding %folderName% - Special %episodeNumber% 480p && %Enc_480% @echo.
			if not exist "%folderName% - Special %episodeNumber% %Tags_480%.mkv" @echo Muxing %folderName% - Special %episodeNumber% 480p && %MuxSpecial_480% && @echo. && @echo.
		)
		if exist "720.avs" (
			if not exist "720.mkv" @echo Encoding %folderName% - Special %episodeNumber% 720p && %Enc_720% && @echo.
			if not exist "%folderName% - Special %episodeNumber% %Tags_720%.mkv" @echo Muxing %folderName% - Special %episodeNumber% 720p && %MuxSpecial_720% && @echo. && @echo.
		)
		if exist "1080.avs" (
			if not exist "1080.mkv" @echo Encoding %folderName% - Special %episodeNumber% 1080p && %Enc_1080% && @echo.
			if not exist "%folderName% - Special %episodeNumber% %Tags_1080%.mkv" @echo Muxing %folderName% - Special %episodeNumber% 1080p && %MuxSpecial_1080% && @echo. && @echo.
		)
	)
	@echo.
	cd..
)
if exist "OVA %episodeNumber%" (
	@echo -----------------------------------OVA %episodeNumber%-----------------------------------
	@echo.
	cd "OVA %episodeNumber%"
	if exist *.m2ts (
		if %renameSource%==true (if not *.m2ts==src.m2ts rename *.m2ts %sourceName%.m2ts)
		if not exist %indexFile% @echo Indexing %folderName% - OVA %episodeNumber% && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" @echo Encoding %folderName% - OVA %episodeNumber% AAC && %audio_AAC% && @echo.
		if not exist "audio.flac" @echo Encoding %folderName% - OVA %episodeNumber% FLAC && %audio_FLAC% && @echo.
		if exist "480.avs" (
			if not exist "480.mkv" @echo Encoding %folderName% - OVA %episodeNumber% 480p && %Enc_480% && @echo.
			if not exist "%folderName% - OVA %episodeNumber% %Tags_480%.mkv" @echo Muxing %folderName% - OVA %episodeNumber% 480p && %MuxOVA_480% && @echo. && @echo.
		)
		if exist "720.avs" (
			if not exist "720.mkv" @echo Encoding %folderName% - OVA %episodeNumber% 720p && %Enc_720% && @echo.
			if not exist "%folderName% - OVA %episodeNumber% %Tags_480%.mkv" @echo Muxing %folderName% - OVA %episodeNumber% 480p && %MuxOVA_480% && @echo. && @echo.
		)
		if exist "1080.avs" (
			if not exist "1080.mkv" @echo Encoding %folderName% - OVA %episodeNumber% 1080p && %Enc_1080% && @echo.
			if not exist "%folderName% - OVA %episodeNumber% %Tags_1080%.mkv" @echo Muxing %folderName% - OVA %episodeNumber% 1080p && %MuxOVA_1080% && @echo. && @echo.
		)
	)
	@echo.
	cd..
)
REM Number of folders to check
if not %folderCount% == %Episodes% goto :loop
pause