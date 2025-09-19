#!/bin/bash

# Source directory containing all .xml files
source_directory="/home/floriane/Documents/Lambert_Daneau/PipeLine-for-Web-interface/new_Lambert34/altos_segmented/content/image"

# Destination directory where subdirectories will be created
destination_directory="/home/floriane/Documents/Lambert_Daneau/PipeLine-for-Web-interface/new_Lambert34/altos_segmented/content/images_c"

# Create destination directory if it doesn't exist
mkdir -p "$destination_directory"

# Counters
dir_counter=1
file_counter=0

# Create the first subdirectory
mkdir -p "$destination_directory/data$dir_counter"

# Iterate over each file in the source directory
for file_path in "$source_directory"/*.xml; do
    mv "$file_path" "$destination_directory/data$dir_counter/"

    ((file_counter++))

    # After 50 files, create a new subdirectory
    if (( file_counter == 50 )); then
        ((dir_counter++))
        mkdir -p "$destination_directory/data$dir_counter"
        file_counter=0
    fi
done
