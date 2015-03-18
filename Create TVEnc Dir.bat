@echo off

REM Place it in your encoding folder and start it whenever you need a directory for a new show (or additional folders in an existing one).

set /p FolderName="Enter Showname: "
@echo.

:RetryEpCount
set /p EpisodeCount="Enter Number of Episodes: "
@echo %EpisodeCount%|findstr /xr "[1-9][0-9]* 0" >nul && (
    @echo. ) || (
    @echo Not a valid number!
    goto :RetryEpCount
)

if not exist "%FolderName%" md "%FolderName%"
cd "%FolderName%"

if %EpisodeCount%==0 goto :end
set Episode_Counter=0
:EpisodeLoop
set /a Episode_Counter=Episode_Counter+1
if %Episode_Counter% LSS 10 set episodeNumber=0%Episode_Counter%
if %Episode_Counter% GEQ 10 set episodeNumber=%Episode_Counter%
if not exist "%episodeNumber%" md "%episodeNumber%"
if not %Episode_Counter% == %EpisodeCount% goto :EpisodeLoop

:Last_Step
if not exist "01" goto :end
cd "01"
if not exist 480.avs @echo. > 480.avs
if not exist 720.avs @echo. > 720.avs

:end
@echo Done!
timeout 1 > nul
REM pause
