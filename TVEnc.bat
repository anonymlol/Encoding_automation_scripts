@echo off
for %%A in ("%CD%") do set "folderNumber=%%~nxA"
for %%A in ("%~dp0..") do set "Showname=%%~nxA"
for %%A in (*.aac) do set "audioName=%%~nA"

REM FTP Settings
set FTP_Username=
set FTP_Password=
set FTP_Host=
set FTP_Path=

REM x264 settings
set Enc_480=x264 --level 4.1 --preset veryslow --colormatrix bt709 --crf 18.0 --log-level none --output "480.mkv" "480.avs"
set Enc_720=x264-10bit --level 5.1 --preset veryslow --crf 18.0 --log-level none --output "720.mkv" "720.avs"

REM vfr.py settings
set Trim_audio=vfr.py -i "%audioName%.aac" -o "audio.mka" -f 24/1.001 -m "480.avs"

REM Tags for the filename
set Tags_480=480 AAC
set Tags_720=720 AAC

REM Muxing settings
set MuxTV_480=mkvmerge -o "%Showname% - %folderNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:848x480" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--default-track" "0:yes" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mka" ")" "--track-order" "0:0,1:0"
set MuxTV_720=mkvmerge -o "%Showname% - %folderNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:eng" "--default-track" "0:yes" "--forced-track" "0:no" "--display-dimensions" "0:1280x720" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--default-track" "0:yes" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mka" ")" "--track-order" "0:0,1:0"

REM Upload settings for wput
set Upload_480=wput --limit-rate=500K --no-directories --binary "%Showname% - %folderNumber% %Tags_480%.mkv" "ftp://%FTP_Username%:%FTP_Password%@%FTP_Host%%FTP_Path%/%folderNumber%/"
set Upload_720=wput --limit-rate=500K --no-directories --binary "%Showname% - %folderNumber% %Tags_720%.mkv" "ftp://%FTP_Username%:%FTP_Password%@%FTP_Host%%FTP_Path%/%folderNumber%/"

@echo Show: %Showname%
@echo.

if not exist "audio.mka" (
	@echo Trimming audio 
	%Trim_audio%
	@echo.
)

if not exist "480.mkv" (
	@echo ------------------%Showname% - %folderNumber% %Tags_480%------------------
	%Enc_480%
	@echo.
	@echo Muxing %Showname% - %folderNumber% %Tags_480%
	%MuxTV_480%
	@echo.
	%Upload_480%
	@echo.
)

if not exist "720.mkv" (
	@echo ------------------%Showname% - %folderNumber% %Tags_720%------------------
	%Enc_720% 
	@echo.
	@echo Muxing %Showname% - %folderNumber% %Tags_720%
	%MuxTV_720%
	@echo.
	%Upload_720%
	@echo.
)

if not exist "%Showname% - %folderNumber% %Tags_480%.mkv" @echo Muxing %Showname% - %folderNumber% %Tags_480% && %MuxTV_480%
if not exist "%Showname% - %folderNumber% %Tags_720%.mkv" @echo Muxing %Showname% - %folderNumber% %Tags_720% && %MuxTV_720%

pause