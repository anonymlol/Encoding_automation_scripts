@echo off

REM Usage: Select both files, but right-click (or drag & drop) only the source (unpatched) file!
REM Will probably add script creation (patch all) for linux/mac later

cd "%~dp1"
if not exist "Patches" md "Patches"

echo Creating Patch...

xdelta3 -s "%~nx1" "%~nx2" "%~n1.delta"
move "%~n1.delta" ./Patches
echo Done.

echo xdelta3 -d -q "%~n1.delta" >> ".\Patches\Patch all.bat"
echo if not exist "old" md "old" >> ".\Patches\Patch all.bat"
echo move "%~nx1" .\old >> ".\Patches\Patch all.bat"
echo move "%~n1.delta" .\old >> ".\Patches\Patch all.bat"
echo. >> ".\Patches\Patch all.bat"

REM pause