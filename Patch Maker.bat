@echo off

REM Usage: Select both files, but right-click/send-to (or drag & drop) only the source (unpatched) file!

cd "%~dp1"
if not exist "Patches" md "Patches"
if not exist ".\Patches\xdelta3.exe" copy "xdelta3.exe" ".\Patches"

echo Creating Patch...

xdelta3 -s "%~nx1" "%~nx2" "%~n1.delta"
move "%~n1.delta" ./Patches
echo Done.

echo xdelta3 -d -q "%~n1.delta" >> ".\Patches\Patch [Windows].bat"
echo if not exist "old" md "old" >> ".\Patches\Patch [Windows].bat"
echo move "%~nx1" .\old >> ".\Patches\Patch [Windows].bat"
echo move "%~n1.delta" .\old >> ".\Patches\Patch [Windows].bat"
echo. >> ".\Patches\Patch [Windows].bat"

REM Mac and Linux scripts below are experimental and probably broken.

REM echo xdelta3 -d -q "%~n1.delta" >> ".\Patches\Patch [Mac].command"
REM echo ^[ -d old ^]^; ^|^| mkdir old >> ".\Patches\Patch [Mac].command"
REM echo mv "%~nx1" ./old >> ".\Patches\Patch [Mac].command"
REM echo mv "%~n1.delta" ./old >> ".\Patches\Patch [Mac].command"
REM echo. >> ".\Patches\Patch [Mac].command"

REM echo xdelta3 -d -q "%~n1.delta" >> ".\Patches\Patch [Linux].sh"
REM echo ^[ -d old ^]^; ^|^| mkdir old >> ".\Patches\Patch [Linux].sh"
REM echo mv "%~nx1" ./old >> ".\Patches\Patch [Linux].sh"
REM echo mv "%~n1.delta" ./old >> ".\Patches\Patch [Linux].sh"
REM echo. >> ".\Patches\Patch [Linux].sh"

REM pause