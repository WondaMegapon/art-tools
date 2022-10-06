@echo off

:: USER VARIABLES

:: Set the bitrate for the video.
set /A BITRATE=32

:: Sets the compression multiplier for the audio.
set /A AUDIOMULTIPLIER=1.75

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
set OUTPUT=%~n1-crunched%EXTENT%

:: Audio Variables
set /A AUDIOBITRATE=%BITRATE% / %AUDIOMULTIPLIER%

:: The Real Magic~
::
ffmpeg -i %INPUT% -b:v %BITRATE%k -b:a %AUDIOBITRATE%k %OUTPUT%

:: Ending the loop.
shift
goto LOOP

:: We're dooone!
:ENDLOOP
echo:
echo:
echo "We're done!"