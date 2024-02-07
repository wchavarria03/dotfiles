#!/usr/bin/env bash

# Function to create needed folders if they don't exist
create_folders() {
    local folders=(~/code ~/Documents/screenshots ~/.config ~/.config/zsh ~/.config/nvim ~/.config/nvim/{backupdir,swap,undodir} ~/.zsh_autoload_functions)
    for folder in "${folders[@]}"; do
        if [[ ! -d "$folder" ]]; then
            mkdir -p "$folder"
            echo "${COLOR_GREEN}Created folder: $folder${COLOR_RESET}"
        fi
    done
}

create_folders
