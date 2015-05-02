@echo off

REM Copy fonts to the subtitle file's folder
REM The chapters file needs "chapter" somewhere in the name, or it won't be auto-detected (also, don't have more than one in the same folder, dunno what will happen otherwise >_>)
REM Right-click the final subfile, send-to: Mux // Or drag & drop subfile onto the .bat file

cd %~p1
for %%A in ("%CD%") do set "folderName=%%~nxA"
for %%A in ("%~dp1..") do set "Showname=%%~nxA"

set group=[Doki]
set subtitle_trackname=ASS

if %folderName:~0,2%==Ep (
	set episodeNumber=%folderName:~-2,2%
)	else (
	set episodeNumber=%folderName%
)

for %%A in ("*.otf") do call set "fonts=%%fonts%% "--attachment-mime-type" "application/vnd.ms-opentype" "--attachment-name" "%%~nxA" "--attach-file" "%%~nxA""
for %%A in ("*.ttf") do call set "fonts=%%fonts%% "--attachment-mime-type" "application/x-truetype-font" "--attachment-name" "%%~nxA" "--attach-file" "%%~nxA""
for %%A in ("*.ttc") do call set "fonts=%%fonts%% "--attachment-mime-type" "application/x-truetype-font" "--attachment-name" "%%~nxA" "--attach-file" "%%~nxA""

for %%A in ("%Showname% - *848x480*h264*.mkv") do set "enc_480_h264=%%~nxA"
for %%A in ("%Showname% - *1280x720*Hi10P*.mkv") do set "enc_720_hi10=%%~nxA"
for %%A in ("%Showname% - *1920x1080 Hi10P*.mkv") do set "enc_1080_hi10=%%~nxA"

for %%A in ("%Showname% - *1280x720*HEVC*.mkv") do set "enc_720_hevc=%%~nxA"
for %%A in ("%Showname% - *1920x1080*HEVC*.mkv") do set "enc_1080_hevc=%%~nxA"

for %%A in ("*chapter*") do call set "chapters_file=%%chapters_file%% "--chapters" "%%~nxA%""

REM Mux settings x264
set MuxEp_480_x264=mkvmerge -o "%group% %enc_480_h264%"  "--quiet" "--display-dimensions" "0:848x480" "(" "%enc_480_h264%" ")" "--language" "0:eng" "--track-name" "0:%subtitle_trackname%" "--forced-track" "0:no" "-s" "0" "-D" "-A" "-T" "--no-global-tags" "--no-chapters" "(" "%~nx1" ")" "--track-order" "0:0,0:1,1:0" "--title" "%group% %enc_480_h264%" "--disable-track-statistics-tags"%chapters_file%%fonts%
set MuxEp_720_x264=mkvmerge -o "%group% %enc_720_hi10%"  "--quiet" "--display-dimensions" "0:1280x720" "(" "%enc_720_hi10%" ")" "--language" "0:eng" "--track-name" "0:%subtitle_trackname%" "--forced-track" "0:no" "-s" "0" "-D" "-A" "-T" "--no-global-tags" "--no-chapters" "(" "%~nx1" ")" "--track-order" "0:0,0:1,1:0" "--title" "%group% %enc_720_hi10%" "--disable-track-statistics-tags"%chapters_file%%fonts%
set MuxEp_1080_x264=mkvmerge -o "%group% %enc_1080_hi10%"  "--quiet" "--display-dimensions" "0:1920x1080" "(" "%enc_1080_hi10%" ")" "--language" "0:eng" "--track-name" "0:%subtitle_trackname%" "--forced-track" "0:no" "-s" "0" "-D" "-A" "-T" "--no-global-tags" "--no-chapters" "(" "%~nx1" ")" "--track-order" "0:0,0:1,1:0" "--title" "%group% %enc_1080_hi10%" "--disable-track-statistics-tags"%chapters_file%%fonts%

REM Mux settings x265
set MuxEp_720_x265=mkvmerge -o "%group% %enc_720_hevc%"  "--quiet" "--display-dimensions" "0:1280x720" "(" "%enc_720_hevc%" ")" "--language" "0:eng" "--track-name" "0:%subtitle_trackname%" "--forced-track" "0:no" "-s" "0" "-D" "-A" "-T" "--no-global-tags" "--no-chapters" "(" "%~nx1" ")" "--track-order" "0:0,0:1,1:0" "--title" "%group% %enc_720_hevc%" "--disable-track-statistics-tags"%chapters_file%%fonts%
set MuxEp_1080_x265=mkvmerge -o "%group% %enc_1080_hevc%"  "--quiet" "--display-dimensions" "0:1920x1080" "(" "%enc_1080_hevc%" ")" "--language" "0:eng" "--track-name" "0:%subtitle_trackname%" "--forced-track" "0:no" "-s" "0" "-D" "-A" "-T" "--no-global-tags" "--no-chapters" "(" "%~nx1" ")" "--track-order" "0:0,0:1,1:0" "--title" "%group% %enc_1080_hevc%" "--disable-track-statistics-tags"%chapters_file%%fonts%

if exist "%enc_480_h264%" if not exist "%group% %enc_480_h264%" @echo Muxing "%group% %enc_480_h264%" && %MuxEp_480_x264% 
if exist "%enc_720_hi10%" if not exist "%group% %enc_720_hi10%" @echo Muxing "%group% %enc_720_hi10%" && %MuxEp_720_x264% 
if exist "%enc_1080_hi10%" if not exist "%group% %enc_1080_hi10%" @echo Muxing "%group% %enc_1080_hi10%" && %MuxEp_1080_x264% 

if exist "%enc_720_hevc%" if not exist "%group% %enc_720_hevc%" @echo Muxing "%group% %enc_720_hevc%" && %MuxEp_720_x265% 
if exist "%enc_1080_hevc%" if not exist "%group% %enc_1080_hevc%" @echo Muxing "%group% %enc_1080_hevc%" && %MuxEp_1080_x265% 

REM pause
