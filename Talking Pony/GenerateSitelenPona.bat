for /f "tokens=*" %%a in (input.txt) do (
  magick convert +antialias -size 128x128 xc:transparent -font linja-sike-5.otf -gravity center -pointsize 128 -fill white -stroke black -strokewidth 8 -annotate +0+0 %%a -stroke none -annotate +0+0 %%a output/%%a.gif
)