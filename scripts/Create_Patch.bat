@echo off
REM Usage: Select both files, but right-click/send-to (or drag & drop) only the source (unpatched) file!

REM Set paths
set xdelta_binary=C:\Doki_Tools\bin\xdelta3.exe
set windows_script=C:\Doki_Tools\scripts\Apply_Patch_Windows.bat
set linux_mac_script=C:\Doki_Tools\scripts\Apply_Patch_Linux_and_Mac.sh

cd "%~dp1"
if not exist "Patches" md "Patches"
if not exist ".\Patches\xdelta3.exe" copy "%xdelta_binary%" ".\Patches"
if not exist ".\Patches\Apply_Patch_Windows.bat" copy "%windows_script%" ".\Patches"
if not exist ".\Patches\Apply_Patch_Linux_and_Mac.sh" copy "%linux_mac_script%" ".\Patches"

echo Creating Patch...
"%xdelta_binary%" -s "%~nx1" "%~nx2" "%~n1.delta"
echo Done.
move "%~n1.delta" ./Patches

REM pause