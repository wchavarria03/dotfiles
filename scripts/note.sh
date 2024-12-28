#!/bin/bash

default_notes_folder="0-Inbox"

# function to prompt the user for a filename
get_filename() {
    read -p "Enter a filename: " filename
    echo "$filename"
}

#rfunction to create and open a file in the specified directory
open_file() {
    # Cd into the directory
    cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/ || exit
    # cd "$NOTES_DIR/$workspace_name" || exit

    filepath="$NOTES_DIR/$default_notes_folder/$filename.md"
    echo filepath

    # Check if the file does not exist
    if [[ ! -f $filepath ]]; then
        # Create the file
        echo "Creating $filepath"
        touch $filepath
    fi

    # create unique identifier and links section
    timestamp="$(date +"%Y%m%d%H%m")"

    # format the file
    {
        echo "# "
        echo "Links:"
        echo "Date: $timestamp"
    } >>$filepath

    echo "Opening $filepath"
    # Open the existing file in nvim
    nvim '+ normal ggzzi' $filepath -c :NoNeckPain
}

# Prompt the user if no filename is provided
if [[ $# -eq 0 ]]; then
    filename=$(get_filename)
fi

# if more than one argument is given, print error message and stop script
if [[ $# -gt 1 ]]; then
    echo "Please provide only one filename separated by dashes, without .md extension."
    echo "Example: zn my-new-note"
    exit 1
fi

# set filename to the argument given to the script
if [[ $# -eq 1 ]]; then
    filename=$1
fi

open_file
