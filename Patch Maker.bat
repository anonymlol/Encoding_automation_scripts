@echo off
REM Usage: Select both files, but right-click/send-to (or drag & drop) only the source (unpatched) file!
REM Requires dos2unix (to convert linux and mac script to unix format), download here: https://sourceforge.net/projects/dos2unix/

REM set paths
set dos2unix_binary=C:\YOURPATH\dos2unix.exe
set xdelta_binary=C:\YOURPATH\xdelta3.exe

cd "%~dp1"
if not exist "Patches" md "Patches"
if not exist ".\Patches\xdelta3.exe" copy "%xdelta_binary%" ".\Patches"

echo Creating Patch...
%xdelta_binary% -s "%~nx1" "%~nx2" "%~n1.delta"
echo Done.
move "%~n1.delta" ./Patches

echo xdelta3 -d -q "%~n1.delta" >> ".\Patches\Patch_Windows.bat"
echo if not exist "old" md "old" >> ".\Patches\Patch_Windows.bat"
echo move "%~nx1" .\old >> ".\Patches\Patch_Windows.bat"
echo move "%~n1.delta" .\old >> ".\Patches\Patch_Windows.bat"
echo. >> ".\Patches\Patch_Windows.bat"

echo xdelta3 -d -q "%~n1.delta" >> ".\Patches\Patch_Linux_and_Mac.sh"
echo mkdir -p old >> ".\Patches\Patch_Linux_and_Mac.sh"
echo mv "%~nx1" ./old >> ".\Patches\Patch_Linux_and_Mac.sh"
echo mv "%~n1.delta" ./old >> ".\Patches\Patch_Linux_and_Mac.sh"
echo. >> ".\Patches\Patch_Linux_and_Mac.sh"
%dos2unix_binary% ".\Patches\Patch_Linux_and_Mac.sh"

REM pause