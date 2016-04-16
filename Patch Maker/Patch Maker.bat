@echo off
REM Usage: Select both files, but right-click/send-to (or drag & drop) only the source (unpatched) file!

REM Set paths
set xdelta_binary=C:\YOURPATH\xdelta3.exe
set windows_script=C:\YOURPATH\Patch_Windows.bat
set linux_mac_script=C:\YOURPATH\Patch_Linux_and_Mac.sh

cd "%~dp1"
if not exist "Patches" md "Patches"
if not exist ".\Patches\xdelta3.exe" copy "%xdelta_binary%" ".\Patches"
if not exist ".\Patches\Patch_Windows.bat" copy "%windows_script%" ".\Patches"
if not exist ".\Patches\Patch_Linux_and_Mac.sh" copy "%linux_mac_script%" ".\Patches"

echo Creating Patch...
"%xdelta_binary%" -s "%~nx1" "%~nx2" "%~n1.delta"
echo Done.
move "%~n1.delta" ./Patches

REM pause