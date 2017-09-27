@echo off

REM x264 settings
set x264_480=avs4x26x -L "x264_64" --level 4.1 --colormatrix bt709 --preset veryslow --crf 16.0 --log-level none --output "480.mkv" "480.avs"
set x264_720=avs4x26x -L "x264_64-10bit" --level 5.1 --preset veryslow --crf 16.0 --input-depth 10 --log-level none --output "720.mkv" "720.avs"
set x264_1080=avs4x26x -L "x264_64-10bit" --level 5.1 --preset veryslow --crf 18.0 --input-depth 10 --log-level none --output "1080.mkv" "1080.avs"

REM x265 settings
set x265_720=avs4x26x -L "x265" --preset veryslow --limit-refs 3 --crf 16.0 --input-depth 10 --recon-depth 10 --output "720_hevc.mkv" "720.avs"
set x265_1080=avs4x26x -L "x265" --preset veryslow --limit-refs 3 --crf 16.0 --input-depth 10 --recon-depth 10 --output "1080_hevc.mkv" "1080.avs"

REM Enable/Disable encodes
set encode_x264_480=true
set encode_x264_720=true
set encode_x264_1080=true

set encode_x265_720=false
set encode_x265_1080=false

REM eac3to settings
set audio_AAC=eac3to src.m2ts 2: audio.mp4 -quality=0.6
set audio_FLAC=eac3to src.m2ts 2: audio.flac -down16

REM Audio Commentary
set encode_commentary=false
set commentary_input=eac3to src.m2ts 3:
set commentary_parameters_aac=-quality=0.6
set commentary_parameters_flac=-down16

REM Settings for creating release folders, adjust the number of volumes according to your needs.
set group=Doki
set number_of_volumes=6
set create_release_folders=true

REM eac3to pgs (.sup) demux settings, switch to "true" and adjust the track number (:5) accordingly if you want to enable it.
set sub_demux=false
set subs_pgs=eac3to src.m2ts 5: subs_1080.sup

REM Set audio for each resolution (muxing). Extensions only.
set audio_480=mp4
set audio_720=mp4
set audio_1080=flac

REM Set your desired filename tags.
set Tags_480_x264=848x480 h264 BD AAC
set Tags_720_x264=1280x720 Hi10P BD AAC
set Tags_1080_x264=1920x1080 Hi10P BD FLAC

set Tags_720_x265=1280x720 HEVC BD AAC
set Tags_1080_x265=1920x1080 HEVC BD FLAC

REM Track-names when muxing.
set video_track_name_480_x264=AVC
set video_track_name_720_x264=AVC
set video_track_name_1080_x264=AVC

set video_track_name_720_x265=HEVC
set video_track_name_1080_x265=HEVC

set audio_track_name_480=AAC
set audio_track_name_720=AAC
set audio_track_name_1080=FLAC

REM Create keyframes files (formerly known as "pass files"). Change to "true" to enable it. Requires SCXvid-standalone and FFmpeg.
set keyframes=false
set ffmpeg_path="ffmpeg"
set SCXvid_path="SCXvid"

REM Indexing settings.
set DGAVCIndex=DGAVCIndex -i "src.m2ts" -o "src.dga" -h
set DGIndexNV=DGIndexNV -i "src.m2ts" -o "src.dgi" -h
set DGIndexIM=DGIndexIM -i "src.m2ts" -o "src.dgi" -h

REM Choose your frameserver.
set Frameserver=%DGIndexNV%

REM Index file name. No need to change anything here.
if "%Frameserver%"=="%DGAVCIndex%" set indexFile="src.dga"
if "%Frameserver%"=="%DGIndexNV%" set indexFile="src.dgi"
if "%Frameserver%"=="%DGIndexIM%" set indexFile="src.dgi"

REM FilterPass to make a filtered, lossless encode and then just resize that. Make sure your ffms2 is up-to-date (10bit support)
set FilterPass=false
set Enc_Lossless=x264-10bit --crf 0.0 --log-level none --output "lossless.mkv" "lossless.avs"

REM Max number of episodes. Doesn't need to be changed unless you need more.
set Episodes=99

REM All m2ts files will be renamed to this. You can disable it by switching "renameSource" to false.
set renameSource=true
set sourceName=src

REM Copy/paste avs scripts from the first folder to the others (only if they don't already exist). You can disable it by switching "copyScripts" to false.
set copyScripts=true
set avsFolder=Ep 01

REM List of additional encoding folders
set type=NCED NCOP Special OVA Menu Movie

for %%A in ("%CD%") do set "folderName=%%~nxA"

if %encode_x264_480%==true if not exist "./Release Folders/%folderName% (*) [%group%][%Tags_480_x264%]" if %create_release_folders%==true md "./Release Folders/%folderName% () [%group%][%Tags_480_x264%]"
if %encode_x264_720%==true if not exist "./Release Folders/%folderName% (*) [%group%][%Tags_720_x264%]" if %create_release_folders%==true md "./Release Folders/%folderName% () [%group%][%Tags_720_x264%]"
if %encode_x264_1080%==true if not exist "./Release Folders/%folderName% (*) [%group%][%Tags_1080_x264%]" if %create_release_folders%==true md "./Release Folders/%folderName% () [%group%][%Tags_1080_x264%]"
if %encode_x265_720%==true if not exist "./Release Folders/%folderName% (*) [%group%][%Tags_720_x265%]" if %create_release_folders%==true md "./Release Folders/%folderName% () [%group%][%Tags_720_x265%]"
if %encode_x265_1080%==true if not exist "./Release Folders/%folderName% (*) [%group%][%Tags_1080_x265%]" if %create_release_folders%==true md "./Release Folders/%folderName% () [%group%][%Tags_1080_x265%]"

set volumeCount=0
:volume_loop
set /a volumeCount=volumeCount+1

if %encode_x264_480%==true if not exist "./Release Folders/[%group%] %folderName% - Vol %volumeCount% (%Tags_480_x264%)" if %create_release_folders%==true md "./Release Folders/[%group%] %folderName% - Vol %volumeCount% (%Tags_480_x264%)"
if %encode_x264_720%==true if not exist "./Release Folders/[%group%] %folderName% - Vol %volumeCount% (%Tags_720_x264%)" if %create_release_folders%==true md "./Release Folders/[%group%] %folderName% - Vol %volumeCount% (%Tags_720_x264%)"
if %encode_x264_1080%==true if not exist "./Release Folders/[%group%] %folderName% - Vol %volumeCount% (%Tags_1080_x264%)" if %create_release_folders%==true md "./Release Folders/[%group%] %folderName% - Vol %volumeCount% (%Tags_1080_x264%)"
if %encode_x265_720%==true if not exist "./Release Folders/[%group%] %folderName% - Vol %volumeCount% (%Tags_720_x265%)" if %create_release_folders%==true md "./Release Folders/[%group%] %folderName% - Vol %volumeCount% (%Tags_720_x265%)"
if %encode_x265_1080%==true if not exist "./Release Folders/[%group%] %folderName% - Vol %volumeCount% (%Tags_1080_x265%)" if %create_release_folders%==true md "./Release Folders/[%group%] %folderName% - Vol %volumeCount% (%Tags_1080_x265%)"

if not %volumeCount% == %number_of_volumes% goto :volume_loop

@echo.
@echo Show: %folderName%
@echo.

set folderCount=0
:loop
set /a folderCount=folderCount+1

if %Episodes% GEQ 100 (
    if %folderCount% LSS 100 set episodeNumber=0%folderCount%
    if %folderCount% LSS 10 set episodeNumber=00%folderCount%
    if %folderCount% GEQ 100 set episodeNumber=%folderCount%
)
if %Episodes% LSS 100 (
    if %folderCount% LSS 10 set episodeNumber=0%folderCount%
    if %folderCount% GEQ 10 set episodeNumber=%folderCount%
)

if exist "Ep %episodeNumber%" (
    @echo -----------------------------------Episode %episodeNumber%-----------------------------------
    @echo.
    cd "Ep %episodeNumber%"
    if exist *.m2ts (
        if %copyScripts%==true (
            if %encode_x264_480%==true if not exist "480.avs" xcopy "%~dp0%avsFolder%\480.avs" && @echo.
            if %encode_x264_720%==true if not exist "720.avs" xcopy "%~dp0%avsFolder%\720.avs" && @echo.
            if %encode_x265_720%==true if not exist "720.avs" xcopy "%~dp0%avsFolder%\720.avs" && @echo.
            if %encode_x264_1080%==true if not exist "1080.avs" xcopy "%~dp0%avsFolder%\1080.avs" && @echo.
            if %encode_x265_1080%==true if not exist "1080.avs" xcopy "%~dp0%avsFolder%\1080.avs" && @echo.
            if %FilterPass%==true if not exist "lossless.avs" xcopy "%~dp0%avsFolder%\lossless.avs" && @echo.
        )
        if %renameSource%==true (if not *.m2ts==src.m2ts rename *.m2ts %sourceName%.m2ts)
        if not exist %indexFile% @echo Indexing %folderName% - %episodeNumber% && %Frameserver% && @echo Indexing done && @echo.
        if %sub_demux%==true (if not exist "subs_1080.sup" @echo Extracting %folderName% - %episodeNumber% Subs && %subs_pgs% && @echo.)
        if not exist "audio.mp4" @echo Encoding %folderName% - %episodeNumber% AAC && %audio_AAC% && @echo.
        if not exist "audio.flac" @echo Encoding %folderName% - %episodeNumber% FLAC && %audio_FLAC% && @echo.
        if exist "audio - Log.txt" del "audio - Log.txt"
        if %encode_commentary%==true (
            if not exist "[%group%] %folderName% - Commentary %episodeNumber%.m4a" @echo Encoding "[%group%] %folderName% - Commentary %episodeNumber%.m4a" && %commentary_input% "[%group%] %folderName% - Commentary %episodeNumber%.m4a" %commentary_parameters_aac% && @echo.
            if not exist "[%group%] %folderName% - Commentary %episodeNumber%.flac" @echo Encoding "[%group%] %folderName% - Commentary %episodeNumber%.flac" && %commentary_input% "[%group%] %folderName% - Commentary %episodeNumber%.flac" %commentary_parameters_flac% && @echo.
            if exist "[%group%] %folderName% - Commentary %episodeNumber% - Log.txt" del "[%group%] %folderName% - Commentary %episodeNumber% - Log.txt"
        )
        if %FilterPass%==true if not exist "lossless.mkv" @echo Encoding FilterPass lossless && %Enc_Lossless% && @echo.
        if exist "480.avs" (
            if %encode_x264_480%==true (
                if not exist "480.mkv" (
                    @echo Encoding %folderName% - %episodeNumber% 480p
                    %x264_480%
                    @echo.
                )
                if not exist "%folderName% - %episodeNumber% (%Tags_480_x264%).mkv" (
                    @echo Muxing %folderName% - %episodeNumber% 480p
                    mkvmerge -o "%folderName% - %episodeNumber% (%Tags_480_x264%).mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_480_x264%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_480%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_480%" ")" "--track-order" "0:0,1:0"
                    @echo.
                    @echo.
                )
            )
            if %keyframes%==true if not exist "%folderName% - %episodeNumber% Keyframes.txt" if exist "480.mkv" @echo Creating Keyframes && %ffmpeg_path% -i "480.mkv" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | %SCXvid_path% "%folderName% - %episodeNumber% Keyframes.txt" && @echo Done && @echo.
        )
        if exist "720.avs" (
            if %encode_x264_720%==true (
                if not exist "720.mkv" @echo Encoding %folderName% - %episodeNumber% 720p && %x264_720% && @echo.
                if not exist "%folderName% - %episodeNumber% (%Tags_720_x264%).mkv" (
                    @echo Muxing %folderName% - %episodeNumber% 720p
                    mkvmerge -o "%folderName% - %episodeNumber% (%Tags_720_x264%).mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_720_x264%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_720%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_720%" ")" "--track-order" "0:0,1:0"
                    @echo.
                    @echo.
                )
            )
            if %keyframes%==true if not exist "%folderName% - %episodeNumber% Keyframes.txt" if exist "720.mkv" @echo Creating Keyframes && %ffmpeg_path% -i "720.mkv" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | %SCXvid_path% "%folderName% - %episodeNumber% Keyframes.txt" && @echo Done && @echo.
            if %encode_x265_720%==true (
                if not exist "720_hevc.mkv" @echo Encoding %folderName% - %episodeNumber% 720p HEVC && %x265_720% && @echo.
                if not exist "%folderName% - %episodeNumber% (%Tags_720_x265%).mkv" (
                    @echo Muxing %folderName% - %episodeNumber% 720p HEVC
                    mkvmerge -o "%folderName% - %episodeNumber% (%Tags_720_x265%).mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_720_x265%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720_hevc.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_720%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_720%" ")" "--track-order" "0:0,1:0"
                    @echo.
                    @echo.
                )
            )
            if %keyframes%==true if not exist "%folderName% - %episodeNumber% Keyframes.txt" if exist "720_hevc.mkv" @echo Creating Keyframes && %ffmpeg_path% -i "720_hevc.mkv" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | %SCXvid_path% "%folderName% - %episodeNumber% Keyframes.txt" && @echo Done && @echo.
        )
        if exist "1080.avs" (
            if %encode_x264_1080%==true (
                if not exist "1080.mkv" @echo Encoding %folderName% - %episodeNumber% 1080p && %x264_1080% && @echo.
                if not exist "%folderName% - %episodeNumber% (%Tags_1080_x264%).mkv" (
                    @echo Muxing %folderName% - %episodeNumber% 1080p
                    mkvmerge -o "%folderName% - %episodeNumber% (%Tags_1080_x264%).mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_1080_x264%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_1080%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_1080%" ")" "--track-order" "0:0,1:0"
                    @echo.
                    @echo.
                )
            )
            if %keyframes%==true if not exist "%folderName% - %episodeNumber% Keyframes.txt" if exist "1080.mkv" @echo Creating Keyframes && %ffmpeg_path% -i "1080.mkv" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | %SCXvid_path% "%folderName% - %episodeNumber% Keyframes.txt" && @echo Done && @echo.
            if %encode_x265_1080%==true (
                if not exist "1080_hevc.mkv" @echo Encoding %folderName% - %episodeNumber% 1080p HEVC && %x265_1080% && @echo.
                if not exist "%folderName% - %episodeNumber% (%Tags_1080_x265%).mkv" (
                    @echo Muxing %folderName% - %episodeNumber% 1080p HEVC
                    mkvmerge -o "%folderName% - %episodeNumber% (%Tags_1080_x265%).mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_1080_x265%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080_hevc.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_1080%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_1080%" ")" "--track-order" "0:0,1:0"
                    @echo.
                    @echo.
                )
            )
            if %keyframes%==true if not exist "%folderName% - %episodeNumber% Keyframes.txt" if exist "1080_hevc.mkv" @echo Creating Keyframes && %ffmpeg_path% -i "1080_hevc.mkv" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | %SCXvid_path% "%folderName% - %episodeNumber% Keyframes.txt" && @echo Done && @echo.
        )
    )
    @echo.
    cd..
)

for %%a in (%type%) do (
    if exist "%%a %episodeNumber%" (
        @echo -----------------------------------%%a %episodeNumber%-----------------------------------
        @echo.
        cd "%%a %episodeNumber%"
        if exist *.m2ts (
            if %copyScripts%==true (
                if %encode_x264_480%==true if not exist "480.avs" xcopy "%~dp0%avsFolder%\480.avs" && @echo.
                if %encode_x264_720%==true if not exist "720.avs" xcopy "%~dp0%avsFolder%\720.avs" && @echo.
                if %encode_x265_720%==true if not exist "720.avs" xcopy "%~dp0%avsFolder%\720.avs" && @echo.
                if %encode_x264_1080%==true if not exist "1080.avs" xcopy "%~dp0%avsFolder%\1080.avs" && @echo.
                if %encode_x265_1080%==true if not exist "1080.avs" xcopy "%~dp0%avsFolder%\1080.avs" && @echo.
                if %FilterPass%==true if not exist "lossless.avs" xcopy "%~dp0%avsFolder%\lossless.avs" && @echo.
            )
            if %renameSource%==true (if not *.m2ts==src.m2ts rename *.m2ts %sourceName%.m2ts)
            if not exist %indexFile% @echo Indexing %folderName% - %%a %episodeNumber% && %Frameserver% && @echo Indexing done && @echo.
            if %sub_demux%==true (if not exist "subs_1080.sup" @echo Extracting %folderName% - %%a %episodeNumber% Subs && %subs_pgs% && @echo.)
            if not exist "audio.mp4" @echo Encoding %folderName% - %%a %episodeNumber% AAC && %audio_AAC% && @echo.
            if not exist "audio.flac" @echo Encoding %folderName% - %%a %episodeNumber% FLAC && %audio_FLAC% && @echo.
            if exist "audio - Log.txt" del "audio - Log.txt"
            if %FilterPass%==true if not exist "lossless.mkv" @echo Encoding FilterPass lossless && %Enc_Lossless% && @echo.
            if exist "480.avs" (
                if %encode_x264_480%==true (
                    if not exist "480.mkv" @echo Encoding %folderName% - %%a %episodeNumber% 480p && %x264_480% && @echo.
                    if not exist "%folderName% - %%a %episodeNumber% (%Tags_480_x264%).mkv" (
                        @echo Muxing %folderName% - %%a %episodeNumber% 480p
                        mkvmerge -o "%folderName% - %%a %episodeNumber% (%Tags_480_x264%).mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_480_x264%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "480.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_480%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_480%" ")" "--track-order" "0:0,1:0"
                        @echo.
                        @echo.
                    )
                )
                if %keyframes%==true if not exist "%folderName% - %%a %episodeNumber% Keyframes.txt" if exist "480.mkv" @echo Creating Keyframes && %ffmpeg_path% -i "480.mkv" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | %SCXvid_path% "%folderName% - %%a %episodeNumber% Keyframes.txt" && @echo Done && @echo.
            )
            if exist "720.avs" (
                if %encode_x264_720%==true (
                    if not exist "720.mkv" @echo Encoding %folderName% - %%a %episodeNumber% 720p && %x264_720% && @echo.
                    if not exist "%folderName% - %%a %episodeNumber% (%Tags_720_x264%).mkv" (
                        @echo Muxing %folderName% - %%a %episodeNumber% 720p
                        mkvmerge -o "%folderName% - %%a %episodeNumber% (%Tags_720_x264%).mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_720_x264%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_720%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_720%" ")" "--track-order" "0:0,1:0"
                        @echo.
                        @echo.
                    )
                )
                if %keyframes%==true if not exist "%folderName% - %%a %episodeNumber% Keyframes.txt" if exist "720.mkv" @echo Creating Keyframes && %ffmpeg_path% -i "720.mkv" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | %SCXvid_path% "%folderName% - %%a %episodeNumber% Keyframes.txt" && @echo Done && @echo.
                if %encode_x265_720%==true (
                    if not exist "720_hevc.mkv" @echo Encoding %folderName% - %%a %episodeNumber% 720p HEVC && %x265_720% && @echo.
                    if not exist "%folderName% - %%a %episodeNumber% (%Tags_720_x265%).mkv" (
                        @echo Muxing %folderName% - %%a %episodeNumber% 720p HEVC
                        mkvmerge -o "%folderName% - %%a %episodeNumber% (%Tags_720_x265%).mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_720_x265%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "720_hevc.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_720%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_720%" ")" "--track-order" "0:0,1:0"
                        @echo.
                        @echo.
                    )
                )
                if %keyframes%==true if not exist "%folderName% - %%a %episodeNumber% Keyframes.txt" if exist "720_hevc.mkv" @echo Creating Keyframes && %ffmpeg_path% -i "720_hevc.mkv" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | %SCXvid_path% "%folderName% - %%a %episodeNumber% Keyframes.txt" && @echo Done && @echo.
            )
            if exist "1080.avs" (
                if %encode_x264_1080%==true (
                    if not exist "1080.mkv" @echo Encoding %folderName% - %%a %episodeNumber% 1080p && %x264_1080% && @echo.
                    if not exist "%folderName% - %%a %episodeNumber% (%Tags_1080_x264%).mkv" (
                        @echo Muxing %folderName% - %%a %episodeNumber% 1080p
                        mkvmerge -o "%folderName% - %%a %episodeNumber% (%Tags_1080_x264%).mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_1080_x264%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_1080%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_1080%" ")" "--track-order" "0:0,1:0"
                        @echo.
                        @echo.
                    )
                )
                if %keyframes%==true if not exist "%folderName% - %%a %episodeNumber% Keyframes.txt" if exist "1080.mkv" @echo Creating Keyframes && %ffmpeg_path% -i "1080.mkv" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | %SCXvid_path% "%folderName% - %%a %episodeNumber% Keyframes.txt" && @echo Done && @echo.
                if %encode_x265_1080%==true (
                    if not exist "1080_hevc.mkv" @echo Encoding %folderName% - %%a %episodeNumber% 1080p HEVC && %x265_1080% && @echo.
                    if not exist "%folderName% - %%a %episodeNumber% (%Tags_1080_x265%).mkv" (
                        @echo Muxing %folderName% - %%a %episodeNumber% 1080p HEVC
                        mkvmerge -o "%folderName% - %%a %episodeNumber% (%Tags_1080_x265%).mkv"  "--quiet" "--language" "0:jpn" "--track-name" "0:%video_track_name_1080_x265%" "--default-track" "0:yes" "--forced-track" "0:no" "-d" "0" "-A" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "1080_hevc.mkv" ")" "--language" "0:jpn" "--track-name" "0:%audio_track_name_1080%" "--forced-track" "0:no" "-a" "0" "-D" "-S" "-T" "--no-global-tags" "--no-chapters" "(" "audio.%audio_1080%" ")" "--track-order" "0:0,1:0"
                        @echo.
                        @echo.
                    )
                )
                if %keyframes%==true if not exist "%folderName% - %%a %episodeNumber% Keyframes.txt" if exist "1080_hevc.mkv" @echo Creating Keyframes && %ffmpeg_path% -i "1080_hevc.mkv" -f yuv4mpegpipe -vf scale=640:360 -pix_fmt yuv420p -vsync drop -loglevel quiet - | %SCXvid_path% "%folderName% - %%a %episodeNumber% Keyframes.txt" && @echo Done && @echo.
            )
        )
        @echo.
        cd..
    )
)

REM Number of folders to check
if not %folderCount% == %Episodes% goto :loop
pause