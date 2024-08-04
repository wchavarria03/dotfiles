#!/bin/bash

# function to create and open a file in the specified directory
open_notes() {
    # Cd into the directory
    cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/ || exit

    nvim
}

open_notes
