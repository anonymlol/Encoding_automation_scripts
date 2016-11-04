@echo off

REM Usage: Drag & Drop files onto the bat to index them or right-click & send to

echo 1) DGIndexNV
echo 2) DGIndexIM
echo 3) DGAVCIndex

echo.
set /p Indexer=Choose Indexer: 
echo.

:loop
if %Indexer%==1 DGIndexNV -i %1 -o "%~n1.dgi" -h
if %Indexer%==2 DGIndexIM -i %1 -o "%~n1.dgi" -h
if %Indexer%==3 DGAVCIndex -i %1 -o "%~n1.dga" -h

shift
if not "%~1"=="" goto :loop

REM pause