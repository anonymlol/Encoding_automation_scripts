@echo off
REM Usage: Select both files and right-click/send-to (or drag & drop) to the batch file!

REM Set paths
set xdelta_binary=C:\Doki_Tools\bin\xdelta3.exe
set windows_script=C:\Doki_Tools\scripts\Apply_Patch_Windows.bat
set linux_mac_script=C:\Doki_Tools\scripts\Apply_Patch_Linux_and_Mac.sh

cd "%~dp1"
if not exist "Patches" md "Patches"
if not exist ".\Patches\xdelta3.exe" copy "%xdelta_binary%" ".\Patches"
if not exist ".\Patches\Apply_Patch_Windows.bat" copy "%windows_script%" ".\Patches"
if not exist ".\Patches\Apply_Patch_Linux_and_Mac.sh" copy "%linux_mac_script%" ".\Patches"

if "%~nx1" LSS "%~nx2" (
    set source="%~nx1"
    set target="%~nx2"
    set patch="%~n1.delta"
) else (
    set source="%~nx2"
    set target="%~nx1"
    set patch="%~n2.delta"
)

echo Old: %source%
echo New: %target%
echo.
echo Creating Patch...
"%xdelta_binary%" -s %source% %target% %patch%
echo Done.
move %patch% ./Patches

pause