magick convert -size 8x8 xc: -channel R -fx "mod(i,4)/3" ^
                      -channel G -fx "mod(j,4)/3" ^
                      -channel B -fx "((i>>2)|(j>>1))/3" ^
          -scale 600% colormap_omo.png