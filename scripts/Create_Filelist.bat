@echo off

REM Saves folder name(s) and the files within as a list in a text file.

set path=%CD%

if exist "Filelist.txt" del "Filelist.txt"

:loop
@echo %1

pushd %1
for %%A in ("%CD%") do set "folderName=%%~nxA"
echo %folderName%>> "%path%\Filelist.txt"
dir /b >> "%path%\Filelist.txt"
echo. >> "%path%\Filelist.txt"
popd

shift
if not "%~1"=="" goto :loop

REM pause