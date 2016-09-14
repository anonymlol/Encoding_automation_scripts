@echo off
for %%A in ("%CD%") do set "folderNumber=%%~nxA"
for %%A in ("%~dp0..") do set "Showname=%%~nxA"
for %%A in (*.aac) do set "audioName=%%~nxA"
for %%A in (*.mkv) do set "mkvSource=%%~nxA"

REM FTP Settings
set FTP_Username=
set FTP_Password=
set FTP_Host=
set FTP_Path=

REM x264 settings
set Enc_480=avs4x26x -L "x264_64" --level 4.1 --preset veryslow --colormatrix bt709 --crf 18.0 --log-level none --output "480.mkv" "480.avs"
set Enc_720=avs4x26x -L "x264_64-10bit" --level 5.1 --preset veryslow --crf 18.0 --input-depth 16 --log-level none --output "720.mkv" "720.avs"

REM vfr.py settings
set Trim_audio=vfr.py -i "%audioName%" -o "audio.mka" -f 24/1.001 -m "480.avs"

REM Tags for the filename
set Tags_480=480 AAC
set Tags_720=720 AAC

REM Track-names when muxing.
set video_track_name_480=AVC
set video_track_name_720=AVC

set audio_track_name_480=AAC
set audio_track_name_720=AAC

REM Create keyframes files (formerly known as "pass files"). Change to "true" to enable it. Requires SCXvid-standalone and FFmpeg.
set keyframes=false
set ffmpeg_path="ffmpeg"
set SCXvid_path="SCXvid"

REM Muxing settings
set MuxTV_480=mkvmerge -o "%Showname% - %folderNumber% %Tags_480%.mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_480%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_480%" "--default-track" "0:yes" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mka" ")" "--track-order" "0:0,1:0"
set MuxTV_720=mkvmerge -o "%Showname% - %folderNumber% %Tags_720%.mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_720%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_720%" "--default-track" "0:yes" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.mka" ")" "--track-order" "0:0,1:0"

REM Upload settings for wput
set Upload_480=wput --limit-rate=500K --no-directories --binary "%Showname% - %folderNumber% %Tags_480%.mkv" "ftp://%FTP_Username%:%FTP_Password%@%FTP_Host%%FTP_Path%/%folderNumber%/"
set Upload_720=wput --limit-rate=500K --no-directories --binary "%Showname% - %folderNumber% %Tags_720%.mkv" "ftp://%FTP_Username%:%FTP_Password%@%FTP_Host%%FTP_Path%/%folderNumber%/"

@echo.
@echo Show: %Showname%
@echo.

if not exist "audio.mka" (
    if exist "%audioName%" (
        @echo Trimming audio
        %Trim_audio%
        @echo.
    )
    if not exist "audio.mka" (
        if exist "%mkvSource%" (
            @echo Demuxing audio from %mkvSource%
            mkvmerge -o "audio.mka"  "--quiet" "--language" "1:jpn" "--forced-track" "1:yes" "-a" "1" "--no-attachments" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "%mkvSource%" ")" "--track-order" "0:1"
            @echo.
        )
    )
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
    @echo.
)

if %keyframes%==true if not exist "%Showname% - %folderNumber% Keyframes.txt" if exist "480.mkv" @echo Creating Keyframes && %ffmpeg_path% -i "480.mkv" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | %SCXvid_path% "%Showname% - %folderNumber% Keyframes.txt" && @echo Done && @echo.


if not exist "720.mkv" (
    @echo ------------------%Showname% - %folderNumber% %Tags_720%------------------
    %Enc_720% 
    @echo.
    @echo Muxing %Showname% - %folderNumber% %Tags_720%
    %MuxTV_720%
    @echo.
    %Upload_720%
    @echo.
    @echo.
)

if %keyframes%==true if not exist "%Showname% - %folderNumber% Keyframes.txt" if exist "720.mkv" @echo Creating Keyframes && %ffmpeg_path% -i "720.mkv" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | %SCXvid_path% "%Showname% - %folderNumber% Keyframes.txt" && @echo Done && @echo.


if not exist "%Showname% - %folderNumber% %Tags_480%.mkv" @echo Muxing %Showname% - %folderNumber% %Tags_480% && %MuxTV_480%
if not exist "%Showname% - %folderNumber% %Tags_720%.mkv" @echo Muxing %Showname% - %folderNumber% %Tags_720% && %MuxTV_720%

pause