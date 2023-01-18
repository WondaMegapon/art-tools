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
  set EXTENT=".png"
) else (
  set EXTENT=%~x1
)
:: Making temporary filenames!
if %FILE%=="" (
  set INPUT="clipboard:"
  set TNAME=clipboard-temp
) else (
  set INPUT=%FILE%
  set TNAME=%~n1-temp
)
echo "Grabbing %INPUT%."

:: Setting the output destination.
if %FILE%=="" (
  set OUTPUT="clipboard:"
) else (
  set OUTPUT=%~n1-small%EXTENT%
)

:: The Real Magic~
::
echo "Compressing Image..."
magick convert %INPUT% -layers RemoveDups %OUTPUT%

:: Ending the loop.
shift
goto LOOP

:: We're dooone!
:ENDLOOP
echo:
echo:
echo "We're done!"