# Requirements
Both apps require [ImageMagick 7](https://imagemagick.org/script/download.php)

([ImageMagick-7.1.0-48-Q16-HDRI-x64-dll.exe](https://imagemagick.org/archive/binaries/ImageMagick-7.1.0-48-Q16-HDRI-x64-dll.exe) is the download that I've personally used.)

# QuickDither
This program crunches input files without any additional button presses. It's quick, but you have to modify the .bat file to change its configuration.

## Warning
This program outputs files named as: 
- `<filename>-temp-mask.<extention>`
- `<filename>-temp-render.<extention>`
- `<filename>-dithered.<extention>`

If the image is from your clipboard, the filename will be `clipboard`. 
The program will not hesitate to overwrite these files. Use it at your own discretion.

## Usage
### Known Compatibilities With
`.png .jpg .gif`
### Existing Files
To use QuickDither with existing files, drag and drop the file you want dithered onto the program. It will create the temporary and final files in the directory that the source image exists in.

### Multiple Files
By selecting multiple files and dragging them all into the program, the program will queue all of them up to process. Doing this may be helpful if you have a bunch of images you want dithered.

### Clipboard Images
If you have the image you want dithered already in your clipboard, simply running the program will dither the image and save it back to your clipboard.

# WebDither **[CURRENTLY UNUSUABLE]**
Will ask questions to better treat images. Good if there's specific details that are needed.