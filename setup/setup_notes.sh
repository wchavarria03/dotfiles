#!/usr/bin/env bash

# Function to setup my personal notes repo
setup_notes() {
    NOTES_PATH=~/personal/notes

    if [ ! -d "$NOTES_PATH" ]; then
        echo "${COLOR_GREEN}-- Cloning notes repo...${COLOR_REST}"
        git clone git@github.com:wchavarria03/notes.git "$NOTES_PATH"
        cd "$NOTES_PATH" || exit
        git lfs install
        git lfs pull
        cd - >/dev/null || exit
    else
        echo "${COLOR_GREEN}-- Updating notes repo...${COLOR_REST}"
        cd "$NOTES_PATH" || exit
        git pull
        cd - >/dev/null || exit
    fi
}

setup_notes_clean_up() {
    echo "${COLOR_GREEN}Setup notes clean up - coming feature...${COLOR_RESET}"
}
