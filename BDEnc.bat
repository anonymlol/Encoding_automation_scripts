@echo off

REM x264 settings
SET Enc_480=x264 --level 4.1 --colormatrix bt709 --preset veryslow --crf 15.0 --log-level none --output "480.mkv" "480.avs"
SET Enc_720=x264-10bit --level 5.1 --preset veryslow --crf 15.0 --log-level none --output "720.mkv" "720.avs"
SET Enc_1080=x264-10bit --level 5.1 --preset veryslow --crf 18.0 --log-level none --output "1080.mkv" "1080.avs"

REM eac3to settings
SET audio_AAC=eac3to src.m2ts 2: audio.mp4 -quality=0.6
SET audio_FLAC=eac3to src.m2ts 2: audio.flac -down16

REM Set your desired filename tags.
SET Tags_480=(848x480 BD AAC)
SET Tags_720=(1280x720 Hi10P BD AAC)
SET Tags_1080=(1920x1080 Hi10P BD FLAC)

REM Indexing settings.
SET DGAVCIndex=DGAVCIndex -i "src.m2ts" -o "src.dga" -h
SET DGIndexNV=DGIndexNV -i "src.m2ts" -o "src.dgi" -h

REM Set your frameserver here. Supported ones are listed above.
SET Frameserver=%DGIndexNV%

REM Leave this if the indexer is in your path. If it isn't, modify the string extraction to return the name of the indexer. Example: start position --> 0,10 <-- amount of letters.
if %Frameserver:~0,10%==DGAVCIndex SET indexFile="src.dga"
if %Frameserver:~0,9%==DGIndexNV SET indexFile="src.dgi"

REM Max number of episodes. Doesn't need to be changed unless you need more.
SET Episodes=100

for %%A in ("%CD%") do set "folderName=%%~nxA"
@echo.
@echo Show: %folderName%
@echo.
SET folderNumber=0
:loop
SET /a folderNumber=folderNumber+1

SET MuxEp_480=mkvmerge -o "%folderName% - %folderNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxEp_720=mkvmerge -o "%folderName% - %folderNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxEp_1080=mkvmerge -o "%folderName% - %folderNumber% %Tags_1080%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.flac" ")" "--track-order" "0:0,1:0"
SET MuxNCED_480=mkvmerge -o "%folderName% - NCED %folderNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxNCED_720=mkvmerge -o "%folderName% - NCED %folderNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxNCED_1080=mkvmerge -o "%folderName% - NCED %folderNumber% %Tags_1080%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.flac" ")" "--track-order" "0:0,1:0"
SET MuxNCOP_480=mkvmerge -o "%folderName% - NCOP %folderNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxNCOP_720=mkvmerge -o "%folderName% - NCOP %folderNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxNCOP_1080=mkvmerge -o "%folderName% - NCOP %folderNumber% %Tags_1080%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxSpecial_480=mkvmerge -o "%folderName% - Special %folderNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxSpecial_720=mkvmerge -o "%folderName% - Special %folderNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxSpecial_1080=mkvmerge -o "%folderName% - Special %folderNumber% %Tags_1080%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.flac" ")" "--track-order" "0:0,1:0"
SET MuxOVA_480=mkvmerge -o "%folderName% - OVA %folderNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxOVA_720=mkvmerge -o "%folderName% - OVA %folderNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxOVA_1080=mkvmerge -o "%folderName% - OVA %folderNumber% %Tags_1080%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.flac" ")" "--track-order" "0:0,1:0"

if exist "Ep %folderNumber%" (
	@echo -----------------------------------Episode %folderNumber%-----------------------------------
	@echo.
	cd "Ep %folderNumber%"
	if exist "src.m2ts" (
		if not exist %indexFile% @echo Indexing %folderName% - %folderNumber% && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" @echo Encoding %folderName% - %folderNumber% AAC && %audio_AAC% && @echo.
		if not exist "audio.flac" @echo Encoding %folderName% - %folderNumber% FLAC && %audio_FLAC% && @echo.
		if exist "480.avs" (
			if not exist "480.mkv" @echo Encoding %folderName% - %folderNumber% 480p && %Enc_480% && @echo. && @echo.
			if not exist "%folderName% - %folderNumber% %Tags_480%.mkv" @echo Muxing %folderName% - %folderNumber% 480p && %MuxEp_480%
		)
		if exist "720.avs" (
			if not exist "720.mkv" @echo Encoding %folderName% - %folderNumber% 720p && %Enc_720% && @echo. && @echo.
			if not exist "%folderName% - %folderNumber% %Tags_720%.mkv" @echo Muxing %folderName% - %folderNumber% 720p && %MuxEp_720%
		)
		if exist "1080.avs" (
			if not exist "1080.mkv" @echo Encoding %folderName% - %folderNumber% 1080p && %Enc_1080%. && @echo. && @echo.
			if not exist "%folderName% - %folderNumber% %Tags_1080%.mkv" @echo Muxing %folderName% - %folderNumber% 1080p && %MuxEp_1080%
		)
	)
	@echo.
	cd..
)
if exist "NCED %folderNumber%" (
	@echo -----------------------------------NCED %folderNumber%-----------------------------------
	@echo.
	cd "NCED %folderNumber%"
	if exist "src.m2ts" (
		if not exist %indexFile% @echo Indexing %folderName% - NCED %folderNumber% && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" @echo Encoding %folderName% - NCED %folderNumber% AAC && %audio_AAC% && @echo.
		if not exist "audio.flac" @echo Encoding %folderName% - NCED %folderNumber% FLAC && %audio_FLAC% && @echo.
		if exist "480.avs" (
			if not exist "480.mkv" @echo Encoding %folderName% - NCED %folderNumber% 480p && %Enc_480% && @echo. && @echo.
			if not exist "%folderName% - NCED %folderNumber% %Tags_480%.mkv" @echo Muxing %folderName% - NCED %folderNumber% 480p && %MuxNCED_480%
		)
		if exist "720.avs" (
			if not exist "720.mkv" @echo Encoding %folderName% - NCED %folderNumber% 720p && %Enc_720% && @echo. && @echo.
			if not exist "%folderName% - NCED %folderNumber% %Tags_720%.mkv" @echo Muxing %folderName% - NCED %folderNumber% 720p && %MuxNCED_720%
		)
		if exist "1080.avs" (
			if not exist "1080.mkv" @echo Encoding %folderName% - NCED %folderNumber% 1080p && %Enc_1080% && @echo. && @echo.
			if not exist "%folderName% - NCED %folderNumber% %Tags_1080%.mkv" @echo Muxing %folderName% - NCED %folderNumber% 1080p && %MuxNCED_1080%
		)
	)
	@echo.
	cd..
)
if exist "NCOP %folderNumber%" (
	@echo -----------------------------------NCOP %folderNumber%-----------------------------------
	@echo.
	cd "NCOP %folderNumber%"
	if exist "src.m2ts" (
		if not exist %indexFile% @echo Indexing %folderName% - NCOP %folderNumber% && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" @echo Encoding %folderName% - NCOP %folderNumber% AAC && %audio_AAC% && @echo.
		if not exist "audio.flac" @echo Encoding %folderName% - NCOP %folderNumber% FLAC && %audio_FLAC% && @echo.
		if exist "480.avs" (
			if not exist "480.mkv" @echo Encoding %folderName% - NCOP %folderNumber% 480p && %Enc_480% && @echo. && @echo.
			if not exist "%folderName% - NCOP %folderNumber% %Tags_480%.mkv" @echo Muxing %folderName% - NCOP %folderNumber% 480p && %MuxNCOP_480%
		)
		if exist "720.avs" (
			if not exist "720.mkv" @echo Encoding %folderName% - NCOP %folderNumber% 720p && %Enc_720% && @echo. && @echo.
			if not exist "%folderName% - NCOP %folderNumber% %Tags_720%.mkv" @echo Muxing %folderName% - NCOP %folderNumber% 720p && %MuxNCOP_720%
		)
		if exist "1080.avs" (
			if not exist "1080.mkv" @echo Encoding %folderName% - NCOP %folderNumber% 1080p && %Enc_1080% && @echo. && @echo.
			if not exist "%folderName% - NCOP %folderNumber% %Tags_1080%.mkv" @echo Muxing %folderName% - NCOP %folderNumber% 1080p && %MuxNCOP_1080%
		)		
	)
	@echo.
	cd..
)
if exist "Special %folderNumber%" (
	@echo -----------------------------------Special %folderNumber%-----------------------------------
	@echo.
	cd "Special %folderNumber%"
	if exist "src.m2ts" (
		if not exist %indexFile% @echo Indexing %folderName% - Special %folderNumber% && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" @echo Encoding %folderName% - Special %folderNumber% AAC && %audio_AAC% && @echo.
		if not exist "audio.flac" @echo Encoding %folderName% - Special %folderNumber% FLAC && %audio_FLAC% && @echo.
		if exist "480.avs" (
			if not exist "480.mkv" @echo Encoding %folderName% - Special %folderNumber% 480p && %Enc_480% @echo. && @echo.
			if not exist "%folderName% - Special %folderNumber% %Tags_480%.mkv" @echo Muxing %folderName% - Special %folderNumber% 480p && %MuxSpecial_480%
		)
		if exist "720.avs" (
			if not exist "720.mkv" @echo Encoding %folderName% - Special %folderNumber% 720p && %Enc_720% && @echo. && @echo.
			if not exist "%folderName% - Special %folderNumber% %Tags_720%.mkv" @echo Muxing %folderName% - Special %folderNumber% 720p && %MuxSpecial_720%
		)
		if exist "1080.avs" (
			if not exist "1080.mkv" @echo Encoding %folderName% - Special %folderNumber% 1080p && %Enc_1080% && @echo. && @echo.
			if not exist "%folderName% - Special %folderNumber% %Tags_1080%.mkv" @echo Muxing %folderName% - Special %folderNumber% 1080p && %MuxSpecial_1080%
		)
	)
	@echo.
	cd..
)
if exist "OVA %folderNumber%" (
	@echo -----------------------------------OVA %folderNumber%-----------------------------------
	@echo.
	cd "OVA %folderNumber%"
	if exist "src.m2ts" (
		if not exist %indexFile% @echo Indexing %folderName% - OVA %folderNumber% && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" @echo Encoding %folderName% - OVA %folderNumber% AAC && %audio_AAC% && @echo.
		if not exist "audio.flac" @echo Encoding %folderName% - OVA %folderNumber% FLAC && %audio_FLAC% && @echo.
		if exist "480.avs" (
			if not exist "480.mkv" @echo Encoding %folderName% - OVA %folderNumber% 480p && %Enc_480% && @echo. && @echo.
			if not exist "%folderName% - OVA %folderNumber% %Tags_480%.mkv" @echo Muxing %folderName% - OVA %folderNumber% 480p && %MuxOVA_480%
		)
		if exist "720.avs" (
			if not exist "720.mkv" @echo Encoding %folderName% - OVA %folderNumber% 720p && %Enc_720% && @echo. && @echo.
			if not exist "%folderName% - OVA %folderNumber% %Tags_480%.mkv" @echo Muxing %folderName% - OVA %folderNumber% 480p && %MuxOVA_480%
		)
		if exist "1080.avs" (
			if not exist "1080.mkv" @echo Encoding %folderName% - OVA %folderNumber% 1080p && %Enc_1080% && @echo. && @echo.
			if not exist "%folderName% - OVA %folderNumber% %Tags_1080%.mkv" @echo Muxing %folderName% - OVA %folderNumber% 1080p && %MuxOVA_1080%
		)
	)
	@echo.
	cd..
)
REM Number of folders to check
if not %folderNumber% == %Episodes% goto :loop
pause