#!/usr/bin/env bash

general_folders() {
    local folders=(~/personal ~/work ~/Documents/screenshots)
    for folder in "${folders[@]}"; do
        if [[ ! -d "$folder" ]]; then
            mkdir -p "$folder"
            echo "${COLOR_GREEN}-- Created folder: $folder${COLOR_RESET}"
        fi
    done
}

work_folders() {
    : # no work-specific folders yet
}

personal_folders() {
    : # no personal-specific folders yet
}

create_folders() {
    # shellcheck source=helpers.sh
    source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
    ensure_device_type

    run_for_device general_folders work_folders personal_folders
}

create_folders_clean_up() {
    echo "${COLOR_GREEN}Create folders clean up - coming feature...${COLOR_RESET}"
}
