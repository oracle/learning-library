#!/bin/bash
# Purpose: batch image resizer using imagemagick (Ubuntu)

# absolute path to image folder
echo ""
PS3=$'\n'"Please select from the list, the image folder path: "
select v_folder_name in $(find "$PWD" -type d -name images); do
  break
done
unset PS3

FOLDER=${v_folder_name}

#Backup folder before resize operation.
cp -r ${FOLDER} ${FOLDER}.bkp
chmod -R 755 ${FOLDER}*

# max width
WIDTH=1280

# max height
HEIGHT=1280

#resize png or jpg to either height or width, keeps proportions using imagemagick
find ${FOLDER} \( -name "*jpg" -o -name "*png" \) -exec convert \{} -verbose -resize $WIDTHx$HEIGHT\> \{} \;
