#!/usr/bin/env bash

# Function to setup my personal notes repo
setup_notes() {
    NOTES_PATH=~/Library/Mobile\ Documents/com~apple~CloudDocs/notes
    echo "---"
    echo $NOTES_PATH
    if [ ! -d "$NOTES_PATH" ]; then
        echo "${COLOR_GREEN}-- Cloning notes repo...${COLOR_REST}"
        git clone https://github.com/wchavarria03/notes "$NOTES_PATH"
    else
        echo "${COLOR_GREEN}-- Updating notes repo...${COLOR_REST}"
        cd "$NOTES_PATH"
        git pull
        cd - >/dev/null # Return to the original directory, suppressing output
    fi

    if [ ! -d "~/personal/notes" ]; then
        echo "${COLOR_GREEN}-- Creating notes repo symblink ...${COLOR_REST}"
        create_symlink "$NOTES_PATH" ~/personal/notes
    else
        echo "${COLOR_GREEN}-- Notes repo symblink its already there...${COLOR_REST}"
    fi
}

create_symlink() {
    local target=$1
    local link_name=$2

    if [ -L "$link_name" ]; then
        echo "${COLOR_YELLOW}- Symlink already exists: $link_name${COLOR_REST}"
    else
        ln -s "$target" "$link_name"
        echo "${COLOR_GREEN}- Created symlink: $link_name -> $target${COLOR_REST}"
    fi
}

setup_notes_clean_up() {
    echo "${COLOR_GREEN}Setup notes clean up - coming feature...${COLOR_RESET}"
}
