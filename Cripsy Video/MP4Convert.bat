@echo off

:: USER VARIABLES

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
set OUTPUT=%~n1-converted.mp4


:: The Real Magic~
::
ffmpeg -i %INPUT%  %OUTPUT%


:: Ending the loop.
shift
goto LOOP

:: We're dooone!
:ENDLOOP
echo:
echo:
echo "We're done!"