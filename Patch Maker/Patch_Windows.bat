@echo off

if not exist old md old

for %%a in (*.delta) do (
    echo Patching "%%~na.mkv" 
    xdelta3 -d -q "%%~a" 
    move "%%~na.*" .\old >nul
)

REM pause