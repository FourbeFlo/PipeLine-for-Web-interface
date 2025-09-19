#!/bin/bash
# Navigate to the "image_c" directory
cd /home/floriane/Documents/Lambert_Daneau/Lambert_topic_modelling/images_d || exit
# Loop through directories starting with "data"
for dir in data*; do
    # Create a zip file for each directory containing only XML files
    find "$dir" -type f -name "*.xml" -exec zip -j "${dir}.zip" {} +
done
