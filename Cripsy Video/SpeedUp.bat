@echo off

:: USER VARIABLES

:: Set the bitrate for the video.
set /A SPEEDRATE=2

:: First time.
goto FIRSTJUMP

:: The main loop!

:LOOP
if "%~1"=="" goto ENDLOOP
:FIRSTJUMP
echo "Found file!"

:: Handling File I/O
::

:: Grabbing the file extention *first*.
set FILE="%~1"
if %FILE%=="" (
  goto ENDLOOP
)

:: File Variables
set EXTENT=%~x1
set INPUT=%FILE%
set TNAME=%~n1-temp
echo "Grabbing %INPUT%."
set OUTPUT=%~n1-fast%EXTENT%


:: The Real Magic~
::
ffmpeg -i %INPUT% -filter_complex "[0:v]setpts=1/%SPEEDRATE%*PTS[v];[0:a]atempo=%SPEEDRATE%[a]" -map "[v]" -map "[a]" %OUTPUT%


:: Ending the loop.
shift
goto LOOP

:: We're dooone!
:ENDLOOP
echo:
echo:
echo "We're done!"