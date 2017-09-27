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

:RetryNCCount
set /p NCCount="Enter Number of NCEDs/NCOPs: "
@echo %NCCount%|findstr /xr "[1-9][0-9]* 0" >nul && (
    @echo. ) || (
    @echo Not a valid number!
    goto :RetryNCCount
)

:RetrySpecialCount
set /p SpecialCount="Enter Number of Specials: "
@echo %SpecialCount%|findstr /xr "[1-9][0-9]* 0" >nul && (
    @echo. ) || (
    @echo Not a valid number!
    goto :RetrySpecialCount
)

:RetryOVACount
set /p OVACount="Enter Number of OVAs: "
@echo %OVACount%|findstr /xr "[1-9][0-9]* 0" >nul && (
    @echo. ) || (
    @echo Not a valid number!
    goto :RetryOVACount
)

:RetryMovieCount
set /p MovieCount="Enter Number of Movies: "
@echo %MovieCount%|findstr /xr "[1-9][0-9]* 0" >nul && (
    @echo. ) || (
    @echo Not a valid number!
    goto :RetryMovieCount
)

:RetryBDMenuCount
set /p BDMenuCount="Enter Number of BD Menus: "
@echo %BDMenuCount%|findstr /xr "[1-9][0-9]* 0" >nul && (
    @echo. ) || (
    @echo Not a valid number!
    goto :RetryBDMenuCount
)

if not exist "%FolderName%" md "%FolderName%"
cd "%FolderName%"

if %EpisodeCount%==0 goto :NC_Step
set Episode_Counter=0
:EpisodeLoop
set /a Episode_Counter=Episode_Counter+1
if %EpisodeCount% GEQ 100 (
    if %Episode_Counter% LSS 100 set episodeNumber=0%Episode_Counter%
    if %Episode_Counter% LSS 10 set episodeNumber=00%Episode_Counter%
    if %Episode_Counter% GEQ 100 set episodeNumber=%Episode_Counter%
)
if %EpisodeCount% LSS 100 (
    if %Episode_Counter% LSS 10 set episodeNumber=0%Episode_Counter%
    if %Episode_Counter% GEQ 10 set episodeNumber=%Episode_Counter%
)
if not exist "Ep %episodeNumber%" md "Ep %episodeNumber%"
if not %Episode_Counter% == %EpisodeCount% goto :EpisodeLoop

:NC_Step
if %NCCount%==0 goto :Special_Step
set NC_Counter=0
:NCLoop
set /a NC_Counter=NC_Counter+1
if %NC_Counter% LSS 10 set NC_Number=0%NC_Counter%
if %NC_Counter% GEQ 10 set NC_Number=%NC_Counter%
if not exist "NCED %NC_Number%" md "NCED %NC_Number%"
if not exist "NCOP %NC_Number%" md "NCOP %NC_Number%"
if not %NC_Counter% == %NCCount% goto :NCLoop

:Special_Step
if %SpecialCount%==0 goto :OVA_Step
set Special_Counter=0
:SpecialLoop
set /a Special_Counter=Special_Counter+1
if %Special_Counter% LSS 10 set Special_Number=0%Special_Counter%
if %Special_Counter% GEQ 10 set Special_Number=%Special_Counter%
if not exist "Special %Special_Number%" md "Special %Special_Number%"
if not %Special_Counter% == %SpecialCount% goto :SpecialLoop

:OVA_Step
if %OVACount%==0 goto :Movie_Step
set OVA_Counter=0
:OVALoop
set /a OVA_Counter=OVA_Counter+1
if %OVA_Counter% LSS 10 set OVA_Number=0%OVA_Counter%
if %OVA_Counter% GEQ 10 set OVA_Number=%OVA_Counter%
if not exist "OVA %OVA_Number%" md "OVA %OVA_Number%"
if not %OVA_Counter% == %OVACount% goto :OVALoop

:Movie_Step
if %MovieCount%==0 goto :BDMenu_Step
set Movie_Counter=0
:MovieLoop
set /a Movie_Counter=Movie_Counter+1
if %Movie_Counter% LSS 10 set Movie_Number=0%Movie_Counter%
if %Movie_Counter% GEQ 10 set Movie_Number=%Movie_Counter%
if not exist "Movie %Movie_Number%" md "Movie %Movie_Number%"
if not %Movie_Counter% == %MovieCount% goto :MovieLoop

:BDMenu_Step
if %BDMenuCount%==0 goto :Last_Step
set BDMenu_Counter=0
:BDMenuLoop
set /a BDMenu_Counter=BDMenu_Counter+1
if %BDMenu_Counter% LSS 10 set BDMenu_Number=0%BDMenu_Counter%
if %BDMenu_Counter% GEQ 10 set BDMenu_Number=%BDMenu_Counter%
if not exist "Menu %BDMenu_Number%" md "Menu %BDMenu_Number%"
if not %BDMenu_Counter% == %BDMenuCount% goto :BDMenuLoop

:Last_Step
if %EpisodeCount% GEQ 100 set template_dir="Ep 001"
if %EpisodeCount% LSS 100 set template_dir="Ep 01"
if not exist %template_dir% goto :end
cd %template_dir%
if not exist 480.avs @echo #AVCSource("src.dga") or DGSource("src.dgi") > 480.avs
if not exist 720.avs @echo #AVCSource("src.dga") or DGSource("src.dgi") > 720.avs
if not exist 1080.avs @echo #AVCSource("src.dga") or DGSource("src.dgi") > 1080.avs

:end
@echo Done!
timeout 1 > nul
REM pause
