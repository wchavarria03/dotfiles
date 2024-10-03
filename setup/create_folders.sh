#!/usr/bin/env bash

# Function to create needed folders if they don't exist
create_folders() {
    local folders=(~/personal ~/work ~/Documents/screenshots)
    for folder in "${folders[@]}"; do
        if [[ ! -d "$folder" ]]; then
            mkdir -p "$folder"
            echo "${COLOR_GREEN}-- Created folder: $folder${COLOR_RESET}"
        fi
    done
}
