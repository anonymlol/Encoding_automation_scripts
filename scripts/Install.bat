@echo off

REM Install directories are C:\Doki_Tools and %userprofile%\AppData\Roaming\Microsoft\Windows\SendTo

REM Various URLs/Paths
set node_version=v4.5.0
set install_dir=C:\Doki_Tools
set sendto_path=%appdata%\Microsoft\Windows\SendTo
set bin_url=https://github.com/anonymlol/Encoding_automation_scripts/raw/master/bin
set scripts_url=https://raw.githubusercontent.com/anonymlol/Encoding_automation_scripts/master/scripts
set node_url=https://nodejs.org/dist/%node_version%/node-%node_version%-x64.msi
set rhash_url=%bin_url%/rhash.exe
set xdelta3_url=%bin_url%/xdelta3.exe
set scxvid_url=%bin_url%/scxvid.exe
set ffmpeg_url=%bin_url%/ffmpeg.exe
set bdenc_url="%scripts_url%/Encode_BD.bat"
set tvenc_url="%scripts_url%/Encode_TV.bat"
set ct_bdencdir_url="%scripts_url%/New_BD_Directory.bat"
set ct_tvencdir_url="%scripts_url%/New_TV_Directory.bat"
set release_muxer_url="%scripts_url%/Release_Muxer.bat"
set patch_maker_url="%scripts_url%/Create_Patch.bat"
set filelist_url="%scripts_url%/Create_Filelist.bat"
set create_torrent_url="%scripts_url%/Create_Torrent.bat"
set create_keyframes_url="%scripts_url%/Create_Keyframes.bat"
set win_patcher_url="%scripts_url%/Apply_Patch_Windows.bat"
set linux_patcher_url="%scripts_url%/Apply_Patch_Linux_and_Mac.sh"

echo #####################################
echo #                                   #
echo #  Doki_Tools Install Script 0.1.0  #
echo #                                   #
echo #####################################
echo.

echo Scripts will be saved to these directories:
echo %install_dir%
echo %sendto_path%
echo.

if not exist "%install_dir%" md "%install_dir%" 
if not exist "%install_dir%\bin" md "%install_dir%\bin"
if not exist "%install_dir%\scripts" md "%install_dir%\scripts"
echo.

if exist "%PROGRAMFILES%\nodejs\node.exe" echo Node found. Proceeding...
if not exist "%PROGRAMFILES%\nodejs\node.exe" set /p node_prompt="Nodejs is required for create-torrent. Install now? (y/n)"
echo.

if /I "%node_prompt%"=="y" (
    if exist "node-%node_version%-x64.msi" (
        echo Found nodejs %node_version% installer, starting now...
        msiexec.exe /i "node-%node_version%-x64.msi"
    )
    if not exist "node-%node_version%-x64.msi" (
        echo Downloading nodejs %node_version%...
        powershell Start-BitsTransfer %node_url%
        echo Download finished, starting installer...
        msiexec.exe /i "node-%node_version%-x64.msi"
    )
    del "node-%node_version%-x64.msi"
    echo.
)

REM echo Installing nodejs modules...
if exist C:\Doki_Tools\node_modules\.bin\create-torrent.cmd set /p install_ct="Create-Torrent found. Reinstall/Update? (y/n)"
echo.

pushd "%install_dir%"
if /I "%install_ct%"=="y" call npm -s install create-torrent && echo.
if /I "%install_dlcli%"=="y" call npm -s install download-cli && echo.
if not exist C:\Doki_Tools\node_modules\.bin\create-torrent.cmd call npm -s install create-torrent && echo.
popd

if exist C:\Doki_Tools\node_modules\.bin set PATH=%PATH%;C:\Doki_Tools\node_modules\.bin

set /p overwrite="Overwrite existing binaries/scripts? (y/n)"
echo.

if exist "%install_dir%\bin\rhash.exe" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %rhash_url% "%install_dir%\bin" && echo Overwrote rhash.exe
if exist "%install_dir%\bin\rhash.exe" if /I "%overwrite%"=="n" echo Skipped rhash.exe
if not exist "%install_dir%\bin\rhash.exe" powershell Start-BitsTransfer %rhash_url% "%install_dir%\bin" && echo Copied rhash.exe

if exist "%install_dir%\bin\scxvid.exe" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %scxvid_url% "%install_dir%\bin" && echo Overwrote scxvid.exe
if exist "%install_dir%\bin\scxvid.exe" if /I "%overwrite%"=="n" echo Skipped scxvid.exe
if not exist "%install_dir%\bin\scxvid.exe" powershell Start-BitsTransfer %scxvid_url% "%install_dir%\bin" && echo Copied scxvid.exe

if exist "%install_dir%\bin\xdelta3.exe" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %xdelta3_url% "%install_dir%\bin" && echo Overwrote xdelta3.exe
if exist "%install_dir%\bin\xdelta3.exe" if /I "%overwrite%"=="n" echo Skipped xdelta3.exe
if not exist "%install_dir%\bin\xdelta3.exe" powershell Start-BitsTransfer %xdelta3_url% "%install_dir%\bin" && echo Copied xdelta3.exe

if exist "%install_dir%\bin\ffmpeg.exe" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %ffmpeg_url% "%install_dir%\bin" && echo Overwrote ffmpeg.exe
if exist "%install_dir%\bin\ffmpeg.exe" if /I "%overwrite%"=="n" echo Skipped ffmpeg.exe
if not exist "%install_dir%\bin\ffmpeg.exe" powershell Start-BitsTransfer %ffmpeg_url% "%install_dir%\bin" && echo Copied ffmpeg.exe

if exist "%install_dir%\scripts\Apply_Patch_Windows.bat" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %win_patcher_url% "%install_dir%\scripts" && echo Overwrote Apply_Patch_Windows.bat
if exist "%install_dir%\scripts\Apply_Patch_Windows.bat" if /I "%overwrite%"=="n" echo Skipped Apply_Patch_Windows.bat
if not exist "%install_dir%\scripts\Apply_Patch_Windows.bat" powershell Start-BitsTransfer %win_patcher_url% "%install_dir%\scripts" && echo Copied Apply_Patch_Windows.bat

if exist "%install_dir%\scripts\Apply_Patch_Linux_and_Mac.sh" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %linux_patcher_url% "%install_dir%\scripts" && echo Overwrote Apply_Patch_Linux_and_Mac.sh
if exist "%install_dir%\scripts\Apply_Patch_Linux_and_Mac.sh" if /I "%overwrite%"=="n" echo Skipped Apply_Patch_Linux_and_Mac.sh
if not exist "%install_dir%\scripts\Apply_Patch_Linux_and_Mac.sh" powershell Start-BitsTransfer %linux_patcher_url% "%install_dir%\scripts" && echo Copied Apply_Patch_Linux_and_Mac.sh

if exist "%install_dir%\scripts\Encode_BD.bat" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %bdenc_url% "%install_dir%\scripts" && echo Overwrote Encode_BD.bat
if exist "%install_dir%\scripts\Encode_BD.bat" if /I "%overwrite%"=="n" echo Skipped Encode_BD.bat
if not exist "%install_dir%\scripts\Encode_BD.bat" powershell Start-BitsTransfer %bdenc_url% "%install_dir%\scripts" && echo Copied Encode_BD.bat

if exist "%install_dir%\scripts\Encode_TV.bat" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %tvenc_url% "%install_dir%\scripts" && echo Overwrote Encode_TV.bat
if exist "%install_dir%\scripts\Encode_TV.bat" if /I "%overwrite%"=="n" echo Skipped Encode_TV.bat
if not exist "%install_dir%\scripts\Encode_TV.bat" powershell Start-BitsTransfer %tvenc_url% "%install_dir%\scripts" && echo Copied Encode_TV.bat

if exist "%install_dir%\scripts\New_BD_Directory.bat" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %ct_bdencdir_url% "%install_dir%\scripts" && echo Overwrote New_BD_Directory.bat
if exist "%install_dir%\scripts\New_BD_Directory.bat" if /I "%overwrite%"=="n" echo Skipped New_BD_Directory.bat
if not exist "%install_dir%\scripts\New_BD_Directory.bat" powershell Start-BitsTransfer %ct_bdencdir_url% "%install_dir%\scripts" && echo Copied New_BD_Directory.bat

if exist "%install_dir%\scripts\New_TV_Directory.bat" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %ct_tvencdir_url% "%install_dir%\scripts" && echo Overwrote New_TV_Directory.bat
if exist "%install_dir%\scripts\New_TV_Directory.bat" if /I "%overwrite%"=="n" echo Skipped New_TV_Directory.bat
if not exist "%install_dir%\scripts\New_TV_Directory.bat" powershell Start-BitsTransfer %ct_tvencdir_url% "%install_dir%\scripts" && echo Copied New_TV_Directory.bat

if exist "%sendto_path%\Create_Torrent.bat" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %create_torrent_url% "%sendto_path%" && echo Overwrote Create_Torrent.bat
if exist "%sendto_path%\Create_Torrent.bat" if /I "%overwrite%"=="n" echo Skipped Create_Torrent.bat
if not exist "%sendto_path%\Create_Torrent.bat" powershell Start-BitsTransfer %create_torrent_url% "%sendto_path%" && echo Copied Create_Torrent.bat

if exist "%sendto_path%\Release_Muxer.bat" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %release_muxer_url% "%sendto_path%" && echo Overwrote Release_Muxer.bat
if exist "%sendto_path%\Release_Muxer.bat" if /I "%overwrite%"=="n" echo Skipped Release_Muxer.bat
if not exist "%sendto_path%\Release_Muxer.bat" powershell Start-BitsTransfer %release_muxer_url% "%sendto_path%" && echo Copied Release_Muxer.bat

if exist "%sendto_path%\Create_Keyframes.bat" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %create_keyframes_url% "%sendto_path%" && echo Overwrote Create_Keyframes.bat
if exist "%sendto_path%\Create_Keyframes.bat" if /I "%overwrite%"=="n" echo Skipped Create_Keyframes.bat
if not exist "%sendto_path%\Create_Keyframes.bat" powershell Start-BitsTransfer %create_keyframes_url% "%sendto_path%" && echo Copied Create_Keyframes.bat

if exist "%sendto_path%\Create_Patch.bat" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %patch_maker_url% "%sendto_path%" && echo Overwrote Create_Patch.bat
if exist "%sendto_path%\Create_Patch.bat" if /I "%overwrite%"=="n" echo Skipped Create_Patch.bat
if not exist "%sendto_path%\Create_Patch.bat" powershell Start-BitsTransfer %patch_maker_url% "%sendto_path%" && echo Copied Create_Patch.bat

if exist "%sendto_path%\Create_Filelist.bat" if /I "%overwrite%"=="y" powershell Start-BitsTransfer %filelist_url% "%sendto_path%" && echo Overwrote Create_Filelist.bat
if exist "%sendto_path%\Create_Filelist.bat" if /I "%overwrite%"=="n" echo Skipped Create_Filelist.bat
if not exist "%sendto_path%\Create_Filelist.bat" powershell Start-BitsTransfer %filelist_url% "%sendto_path%" && echo Copied Create_Filelist.bat

echo.
echo All done! Or so you thought...
echo.

pause