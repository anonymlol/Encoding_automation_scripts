@echo off

REM Place it in your encoding folder and start it whenever you need a directory for a new show (or additional folders in an existing one).

set /p FolderName=Enter Showname:
@echo.

:RetryEpCount
set /p EpisodeCount=Enter Number of Episodes:
@echo %EpisodeCount%|findstr /xr "[1-9][0-9]* 0" >nul && (
	@echo. ) || (
	@echo Not a valid number!
	goto :RetryEpCount
)

:RetryNCCount
set /p NCCount=Enter Number of NCEDs/NCOPs:
@echo %NCCount%|findstr /xr "[1-9][0-9]* 0" >nul && (
	@echo. ) || (
	@echo Not a valid number!
	goto :RetryNCCount
)

:RetrySpecialCount
set /p SpecialCount=Enter Number of Specials:
@echo %SpecialCount%|findstr /xr "[1-9][0-9]* 0" >nul && (
	@echo. ) || (
	@echo Not a valid number!
	goto :RetrySpecialCount
)

:RetryOVACount
set /p OVACount=Enter Number of OVAs:
@echo %OVACount%|findstr /xr "[1-9][0-9]* 0" >nul && (
	@echo. ) || (
	@echo Not a valid number!
	goto :RetryOVACount
)

if not exist %FolderName% md %FolderName%
cd %FolderName%

set Episode_Counter=0
:EpisodeLoop
set /a Episode_Counter=Episode_Counter+1
if %Episode_Counter% LSS 10 set episodeNumber=0%Episode_Counter%
if %Episode_Counter% GEQ 10 set episodeNumber=%Episode_Counter%
if not exist "Ep %episodeNumber%" md "Ep %episodeNumber%"
if not %Episode_Counter% == %EpisodeCount% goto :EpisodeLoop

set NC_Counter=0
:NCLoop
set /a NC_Counter=NC_Counter+1
if %NC_Counter% LSS 10 set NC_Number=0%NC_Counter%
if %NC_Counter% GEQ 10 set NC_Number=%NC_Counter%
if not exist "NCED %NC_Number%" md "NCED %NC_Number%"
if not exist "NCOP %NC_Number%" md "NCOP %NC_Number%"
if not %NC_Counter% == %NCCount% goto :NCLoop

set Special_Counter=0
:SpecialLoop
set /a Special_Counter=Special_Counter+1
if %Special_Counter% LSS 10 set Special_Number=0%Special_Counter%
if %Special_Counter% GEQ 10 set Special_Number=%Special_Counter%
if not exist "Special %Special_Number%" md "Special %Special_Number%"
if not %Special_Counter% == %SpecialCount% goto :SpecialLoop

set OVA_Counter=0
:OVALoop
set /a OVA_Counter=OVA_Counter+1
if %OVA_Counter% LSS 10 set OVA_Number=0%OVA_Counter%
if %OVA_Counter% GEQ 10 set OVA_Number=%OVA_Counter%
if not exist "OVA %OVA_Number%" md "OVA %OVA_Number%"
if not %OVA_Counter% == %OVACount% goto :OVALoop

cd "Ep 01"
if not exist 480.avs @echo #AVCSource("src.dga") or DGSource("src.dgi") > 480.avs
if not exist 720.avs @echo #AVCSource("src.dga") or DGSource("src.dgi") > 720.avs
if not exist 1080.avs @echo #AVCSource("src.dga") or DGSource("src.dgi") > 1080.avs

@echo Done!
timeout 1 > nul
REM pause