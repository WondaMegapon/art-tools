@echo on

:: USER VARIABLES

:: Changes the amount that the image is downscaled. Bigger numbers mean smaller images. Default is 2.
set /P DOWNSCALING=Width of desired image(s)
set /A DOWNSCALING=%DOWNSCALING%
if %DOWNSCALING% leq 0 (
  set /P DOWNSCALING=Scale of desired image(s)
  set /A DOWNSCALING=%DOWNSCALING%
  if %DOWNSCALING% leq 0 (
    set UPSCALING=""
    set DOWNSCALING=""
    printf "Disabled scaling.\n"
  ) else (
    set /A UPSCALING=100 * %DOWNSCALING%
    set UPSCALING=-scale %UPSCALING%%%
    set /A DOWNSCALING= 100 / %DOWNSCALING%
    set DOWNSCALING=-scale %DOWNSCALING%%%
    printf "Scaling set to %DOWNSCALING%.\n"
  )
) else (
  set UPSCALING=""
  set DOWNSCALING=-width %DOWNSCALING%
  pause
  printf "Width set to %DOWNSCALING%.\n"
)

if UPSCALING neq "" (
  set /A DOWNSCALE=100 / SCALINGFACTOR
  if %DOWNSCALE% leq 0 (set /A DOWNSCALE = 1)
  set /A UPSCALE=100 * SCALINGFACTOR
  if %UPSCALE% gtr 10000 (set /A UPSCALE = 10000)
  echo Downscaling by %DOWNSCALE%%% and upscaling by %DOWNSCALE%%%.
)

:: Remembering our colormap.
set COLORMAP=%~dp0colormap_88.png

:: The main loop!

:LOOP
if "%~1"=="" goto ENDLOOP
printf "\nFound file!\n"

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
printf "Grabbing %INPUT%.\n"

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
printf "Creating Mask...\n"
magick convert %INPUT% +dither -alpha set -coalesce -scale %DOWNSCALING% -ordered-dither o4x4,8 -channel A -separate -threshold 50%% %MASK%
printf "Dithering and Downscaling Image...\n"
magick convert %INPUT% +dither -alpha set -coalesce -scale %DOWNSCALING% -ordered-dither o4x4,8 -remap "%COLORMAP%" %RENDER%
printf "Compositing Images...\n"
magick convert %RENDER% -coalesce null: %MASK% -compose CopyOpacity -layers composite -set dispose background %RENDER%
printf "Upscaling Images...\n"
magick convert %RENDER% %UPSCALING% %OUTPUT%
printf "Done with %OUTPUT%!\n"

:: Removing the temporary images.
printf "Removing %MASK%.\n"
rm %MASK%
printf "Removing %RENDER%.\n"
rm %RENDER%

:: Ending the loop.
shift
goto LOOP

:: We're dooone!
:ENDLOOP
printf "\n\n\nWe're done!\n"
pause
