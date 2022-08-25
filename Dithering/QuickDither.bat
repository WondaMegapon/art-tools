@echo off

:: USER VARIABLES

:: Changes the amount that the image is downscaled. Bigger numbers mean smaller images. Default is 2.
set /A SCALINGFACTOR = 2
echo "Scaling set to %SCALINGFACTOR%!"

:: Handling User variables.
::
set /A DOWNSCALE = 100 / SCALINGFACTOR
if %DOWNSCALE% leq 0 (set /A DOWNSCALE = 1)
set /A UPSCALE = 100 * SCALINGFACTOR
if %UPSCALE% gtr 10000 (set /A UPSCALE = 10000)
echo "Downscaling by %DOWNSCALE%%% and upscaling by %DOWNSCALE%%%."
echo:

:: Remembering our colormap.
set COLORMAP=%~dp0colormap_88.png

:: The main loop!

:LOOP
if "%~1"=="" goto ENDLOOP
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

:: Common variables for both actions.
set MASK="%TNAME%-mask%EXTENT%"
set RENDER="%TNAME%-render%EXTENT%"

:: Setting the output destination.
if %FILE%=="" (
  set OUTPUT="clipboard:"
) else (
  set OUTPUT=%~n1-dithered%EXTENT%
)

:: The Real Magic~
::
echo "Creating Mask..."
magick convert %INPUT% +dither -alpha set -coalesce -scale %DOWNSCALE%%% -ordered-dither o4x4,8 -channel A -separate -threshold 50%% %MASK%
echo "Dithering and Downscaling Image..."
magick convert %INPUT% +dither -alpha set -coalesce -scale %DOWNSCALE%%% -ordered-dither o4x4,8 -remap "%COLORMAP%" %RENDER%
echo "Compositing Images..."
magick convert %RENDER% -coalesce null: %MASK% -compose CopyOpacity -layers composite -set dispose background %RENDER%
echo "Upscaling Images..."
magick convert %RENDER% -scale %UPSCALE%%% %OUTPUT%
echo "Done with %OUTPUT%!"

:: Removing the temporary images.
echo "Removing %MASK%."
del %MASK%
echo "Removing %RENDER%."
del %RENDER%

:: Ending the loop.
shift
goto LOOP

:: We're dooone!
:ENDLOOP
echo:
echo:
echo "We're done!"
echo:
pause