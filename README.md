### Install.bat
Installs node and saves scripts and binaries to `C:\Doki_Tools` and `%appdata%\Microsoft\Windows\SendTo`

### New BD/TV Directory.bat
These create directories for Encode_BD or Encode_TV.

### Encode_BD (Blu-Ray Anime Encode Script)
- Renames the source files (i.e. "00000.m2ts" to "src.m2ts")
- Copies .avs files from a previous directory (default "Ep 01")
- Indexes the source
- Encodes audio
- Encodes video
- demuxes PGS subs
- creates keyframe files (requires [SCXvid-standalone](https://github.com/soyokaze/SCXvid-standalone/releases) and [FFmpeg](http://ffmpeg.zeranoe.com/builds/))
- Muxes (with correct names/numbers fetched from the folders, for example: "Showname - NCED 01 480 AAC.mkv")

A specific folder structure is necessary. Use "New BD/TV Directory.bat".

For piping to 64-bit x264/x265, you need [avs4x26x](http://forum.doom9.org/showthread.php?t=162656).

### Encode_TV (TV Anime Encode Script)
Encodes, muxes, names and uploads (ftp) TV encodes. 

Needs [wput](http://wput.sourceforge.net/) for uploading and [vfr.py](https://github.com/wiiaboo/vfr/releases) for trimming the audio.

### Release_Muxer
Muxes finished episodes for release.

### Create_Torrent
Can create multiple torrent files at once. Comes with multiple trackers preset.

### Create_Patch
Creates patches quickly.

Usage: Select both files and right-click/send-to (or drag & drop) to the batch file!


### Create_Filelist
Creates a text file containing folder/file names. Useful for release posts.
