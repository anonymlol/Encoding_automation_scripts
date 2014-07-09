BDBatchEnc
==========

The script does the following:
- Checks if an index file is present / Indexes if not
- Checks if the files need to be encoded / Encodes them if they're missing
- Checks if the files need to be muxed / Muxes them if no muxed files are present
- Fetches the show name from parent dir for the muxing
- Numbers and names the files correctly (for example: "Showname - NCED 1 480 AAC.mkv")

A specific folder structure is necessary. You can get a template from [here](https://db.tt/TmWeTOYD).

TVEnc
==========
Encodes, muxes, names and uploades TV encodes.

Folder structure: Showname/01/TVEnc.bat
Requirements:
[wput](http://wput.sourceforge.net/) for uploading (TVEnc only)
[vfr.py](https://github.com/wiiaboo/vfr/releases) for trimming audio
