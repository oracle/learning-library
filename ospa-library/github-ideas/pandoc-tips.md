# Pandoc    ----    [RETURN](README.md)

### Someone (I think Dan) found the "pandoc" tool online [http://pandoc.org](http://pandoc.org) and suggested it.

### NOTE: You may continue with the manual process below, but we recommend that you use the Python "converter" script supplied [Converter Scripts](docx_md_converter_scripts.md)

### I found was able to convert .docx files to .md with limited fuss in a short time.

### Here's a process that worked for me.
* I use a Mac so only the command-line is an option
* Dan and Eugenio have tried the MS Word plug-in "writage" [http://writage.com](http://writage.com/)
* Remember this is open source and you get what you pay for... - issues we've seen so far
  * Images get converted to .tiff and .png (not sure what criteria is used)
  * "Stray" characters sometimes appear (usually on lines by themselves)
  * I found case where the CASE of some words was altered, usually in headings and titles
  * We've heard reports that tables take lots of additional work after conversion


1. Download/install Pandoc
1. Obtain copy of .docx file
1. Execute pandoc command making sure to extract-media and specify github format

    __pandoc --extract-media  .  -s ShowItBuildIt_MoveImproveDatabase_Standardized_LAB_guide_2_13.docx -t gfm -o MoveImproveDatabase.md__

    Creates file name MoveImproveDatabase.md
    Creates media folder with combination of .tiff and .png images

1. Open .md file in editor to verify that it did most of what you wanted

1. In github click on desired folder

1. "Drag and Drop" (or use Browse) to copy /images folder and all .md files into folder

