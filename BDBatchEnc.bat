@echo off

REM x264 settings
SET SD_480=x264 --level 4.1 --colormatrix bt709 --preset veryslow --crf 15.0 --output "480.mkv" "480.avs"
SET HD_720=x264-10bit --level 5.1 --preset veryslow --crf 15.0 --output "720.mkv" "720.avs"
SET HD_1080=x264-10bit --level 5.1 --preset veryslow --crf 18.0 --output "1080.mkv" "1080.avs"

REM eac3to settings
SET audio_AAC=eac3to src.m2ts 2: audio.mp4 -quality=0.6
SET audio_FLAC=eac3to src.m2ts 2: audio.flac -down16

REM Defining frameservers and their indexing parameters.
SET DGAVCIndex=DGAVCIndex -i "src.m2ts" -o "src.dga" -h
SET DGIndexNV=DGIndexNV -i "src.m2ts" -o "src.dgi" -h

REM Set your frameserver here. Supported ones are listed above.
SET Frameserver=%DGIndexNV%

REM Sets the max number of episodes. Doesn't need to be changed unless you need more.
SET Episodes=100

for %%A in ("%CD%") do set "folderName=%%~nxA"
@echo.
@echo Show Name: %folderName%
@echo.
SET folderNumber=0
:loop
SET /a folderNumber=folderNumber+1

SET MuxEp_480=mkvmerge -o "%folderName% - %folderNumber% 480 AAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxEp_720=mkvmerge -o "%folderName% - %folderNumber% 720 AAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxEp_1080=mkvmerge -o "%folderName% - %folderNumber% 1080 FLAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.flac" ")" "--track-order" "0:0,1:0"
SET MuxNCED_480=mkvmerge -o "%folderName% - NCED %folderNumber% 480 AAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxNCED_720=mkvmerge -o "%folderName% - NCED %folderNumber% 720 AAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxNCED_1080=mkvmerge -o "%folderName% - NCED %folderNumber% 1080 FLAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.flac" ")" "--track-order" "0:0,1:0"
SET MuxNCOP_480=mkvmerge -o "%folderName% - NCOP %folderNumber% 480 AAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxNCOP_720=mkvmerge -o "%folderName% - NCOP %folderNumber% 720 AAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxNCOP_1080=mkvmerge -o "%folderName% - NCOP %folderNumber% 1080 FLAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxSpecial_480=mkvmerge -o "%folderName% - Special %folderNumber% 480 AAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxSpecial_720=mkvmerge -o "%folderName% - Special %folderNumber% 720 AAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxSpecial_1080=mkvmerge -o "%folderName% - Special %folderNumber% 1080 FLAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.flac" ")" "--track-order" "0:0,1:0"
SET MuxOVA_480=mkvmerge -o "%folderName% - OVA %folderNumber% 480 AAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxOVA_720=mkvmerge -o "%folderName% - OVA %folderNumber% 720 AAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mp4" ")" "--track-order" "0:0,1:0"
SET MuxOVA_1080=mkvmerge -o "%folderName% - OVA %folderNumber% 1080 FLAC.mkv"  "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1920x1080" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.flac" ")" "--track-order" "0:0,1:0"

if exist "Ep %folderNumber%" (
	@echo -----------------------------------Episode %folderNumber%-----------------------------------
	@echo.
	cd "Ep %folderNumber%"
	if exist "src.m2ts" (
		if not exist "src.dgi" @echo Indexing && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" %audio_AAC% && @echo.
		if not exist "audio.flac" %audio_FLAC% && @echo.
		if not exist "480.mkv" %SD_480% && @echo. && %MuxEp_480% && @echo. && @echo.
		if not exist "720.mkv" %HD_720% && @echo. && %MuxEp_720% && @echo. && @echo.
		if not exist "1080.mkv" %HD_1080% && @echo. && %MuxEp_1080% && @echo. && @echo.
		if not exist "%folderName% - %folderNumber% 480 AAC.mkv" %MuxEp_480% && @echo.
		if not exist "%folderName% - %folderNumber% 720 AAC.mkv" %MuxEp_720% && @echo.
		if not exist "%folderName% - %folderNumber% 1080 FLAC.mkv" %MuxEp_1080% && @echo.
	)
	@echo.
	cd..
)
if exist "NCED %folderNumber%" (
	@echo -----------------------------------NCED %folderNumber%-----------------------------------
	@echo.
	cd "NCED %folderNumber%"
	if exist "src.m2ts" (
		if not exist "src.dgi" @echo Indexing && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" %audio_AAC% && @echo.
		if not exist "audio.flac" %audio_FLAC% && @echo.
		if not exist "480.mkv" %SD_480% && @echo. && %MuxNCED_480% && @echo. && @echo.
		if not exist "720.mkv" %HD_720% && @echo. && %MuxNCED_720% && @echo. && @echo.
		if not exist "1080.mkv" %HD_1080% && @echo. && %MuxNCED_1080% && @echo. && @echo.
		if not exist "%folderName% - NCED %folderNumber% 480 AAC.mkv" %MuxNCED_480% && @echo.
		if not exist "%folderName% - NCED %folderNumber% 720 AAC.mkv" %MuxNCED_720% && @echo.
		if not exist "%folderName% - NCED %folderNumber% 1080 FLAC.mkv" %MuxNCED_1080% && @echo.
	)
	@echo.
	cd..
)
if exist "NCOP %folderNumber%" (
	@echo -----------------------------------NCOP %folderNumber%-----------------------------------
	@echo.
	cd "NCOP %folderNumber%"
	if exist "src.m2ts" (
		if not exist "src.dgi" @echo Indexing && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" %audio_AAC% && @echo.
		if not exist "audio.flac" %audio_FLAC% && @echo.
		if not exist "480.mkv" %SD_480% && @echo. && %MuxNCOP_480% && @echo. && @echo.
		if not exist "720.mkv" %HD_720% && @echo. && %MuxNCOP_720% && @echo. && @echo.
		if not exist "1080.mkv" %HD_1080% && @echo. && %MuxNCOP_1080% && @echo. && @echo.
		if not exist "%folderName% - NCOP %folderNumber% 480 AAC.mkv" %MuxNCOP_480% && @echo.
		if not exist "%folderName% - NCOP %folderNumber% 720 AAC.mkv" %MuxNCOP_720% && @echo.
		if not exist "%folderName% - NCOP %folderNumber% 1080 FLAC.mkv" %MuxNCOP_1080% && @echo.
	)
	@echo.
	cd..
)
if exist "Special %folderNumber%" (
	@echo -----------------------------------Special %folderNumber%-----------------------------------
	@echo.
	cd "Special %folderNumber%"
	if exist "src.m2ts" (
		if not exist "src.dgi" @echo Indexing && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" %audio_AAC% && @echo.
		if not exist "audio.flac" %audio_FLAC% && @echo.
		if not exist "480.mkv" %SD_480% && @echo. && %MuxSpecial_480% && @echo. && @echo.
		if not exist "720.mkv" %HD_720% && @echo. && %MuxSpecial_720% && @echo. && @echo.
		if not exist "1080.mkv" %HD_1080% && @echo. && %MuxSpecial_1080% && @echo. && @echo.
		if not exist "%folderName% - Special %folderNumber% 480 AAC.mkv" %MuxSpecial_480% && @echo.
		if not exist "%folderName% - Special %folderNumber% 720 AAC.mkv" %MuxSpecial_720% && @echo.
		if not exist "%folderName% - Special %folderNumber% 1080 FLAC.mkv" %MuxSpecial_1080% && @echo.
	)
	@echo.
	cd..
)
if exist "OVA %folderNumber%" (
	@echo -----------------------------------OVA %folderNumber%-----------------------------------
	@echo.
	cd "OVA %folderNumber%"
	if exist "src.m2ts" (
		if not exist "src.dgi" @echo Indexing && %Frameserver% && @echo Indexing done && @echo.
		if not exist "audio.mp4" %audio_AAC% && @echo.
		if not exist "audio.flac" %audio_FLAC% && @echo.
		if not exist "480.mkv" %SD_480% && @echo. && %MuxOVA_480% && @echo. && @echo.
		if not exist "720.mkv" %HD_720% && @echo. && %MuxOVA_720% && @echo. && @echo.
		if not exist "1080.mkv" %HD_1080% && @echo. && %MuxOVA_1080% && @echo. && @echo.
		if not exist "%folderName% - OVA %folderNumber% 480 AAC.mkv" %MuxOVA_480% && @echo.
		if not exist "%folderName% - OVA %folderNumber% 720 AAC.mkv" %MuxOVA_720% && @echo.
		if not exist "%folderName% - OVA %folderNumber% 1080 FLAC.mkv" %MuxOVA_1080% && @echo.
	)
	@echo.
	cd..
)
REM Number of folders to check
if not %folderNumber% == %Episodes% goto :loop
pause