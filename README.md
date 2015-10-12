### BDEnc ###
- Renames the source files (i.e. "00000.m2ts" to "src.m2ts")
- Copies .avs files from a previous directory (default "Ep 01")
- Indexes the source
- Encodes audio
- Encodes video
- demuxes PGS subs
- creates keyframe files (requires [SCXvid-standalone](https://github.com/soyokaze/SCXvid-standalone/releases) and [FFmpeg](http://ffmpeg.zeranoe.com/builds/))
- Muxes (with correct names/numbers fetched from the folders, for example: "Showname - NCED 01 480 AAC.mkv")

A specific folder structure is necessary. Use this [BD Template](https://db.tt/295TS1NH) or the new [Create BDEnc Dir.bat](https://github.com/anonymlol/Encoding_automation_scripts/blob/master/Create%20BDEnc%20Dir.bat) (highly recommended).

For piping to 64-bit x264/x265, you need [avs4x26x](http://forum.doom9.org/showthread.php?t=162656).

### Create BDEnc/TVEnc Dir ###
These create directories for BDEnc or TVEnc.

### TVEnc ###
Encodes, muxes, names and uploads TV encodes. 

Needs [wput](http://wput.sourceforge.net/) for uploading and [vfr.py](https://github.com/wiiaboo/vfr/releases) for trimming the audio.

Use the following folder structure: Showname/01/TVEnc.bat ([TV Template](https://db.tt/KL9PKl0t) or [Create TVEnc Dir.bat](https://github.com/anonymlol/Encoding_automation_scripts/blob/master/Create%20TVEnc%20Dir.bat))
