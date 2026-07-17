#!/usr/bin/env bash

# Function to setup my personal notes repo
setup_notes() {
    NOTES_PATH=~/personal/notes

    if [ ! -d "$NOTES_PATH" ]; then
        echo "${COLOR_GREEN}-- Cloning notes repo...${COLOR_RESET}"
        git clone git@github.com:wchavarria03/notes.git "$NOTES_PATH"
        cd "$NOTES_PATH" || exit
        git lfs install
        git lfs pull
        cd - >/dev/null || exit
    else
        echo "${COLOR_GREEN}-- Updating notes repo...${COLOR_RESET}"
        cd "$NOTES_PATH" || exit
        git pull
        cd - >/dev/null || exit
    fi

    link_streaming_assets
}

# Symlinks the streaming assets folder from the notes repo into ~/Documents/Streaming.
# Keeps the notes repo as the single source of truth — GIMP/OBS point at the
# symlink, not a separate copy that can drift out of sync.
link_streaming_assets() {
    local link=~/Documents/Streaming/Assets
    local target="$NOTES_PATH/attachments/streaming"

    if [[ -L "$link" ]]; then
        echo "${COLOR_GREEN}-- Streaming assets symlink already exists.${COLOR_RESET}"
    elif [[ -e "$link" ]]; then
        echo "WARNING: $link exists and is not a symlink — skipping. Remove it manually to re-link."
    else
        mkdir -p "$(dirname "$link")"
        ln -s "$target" "$link"
        echo "${COLOR_GREEN}-- Linked $link -> $target${COLOR_RESET}"
    fi
}

setup_notes_clean_up() {
    echo "${COLOR_GREEN}Setup notes clean up - coming feature...${COLOR_RESET}"
}
