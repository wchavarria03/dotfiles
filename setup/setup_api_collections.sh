#!/usr/bin/env bash

general_api_collections() {
    if [ ! -d ~/personal/my-api-collections/ ]; then
        echo "${COLOR_GREEN}-- Cloning collections repo...${COLOR_RESET}"
        git clone git@github.com:wchavarria03/my-api-collections.git ~/personal/my-api-collections
    else
        echo "${COLOR_GREEN}-- Updating collections repo...${COLOR_RESET}"
        cd ~/personal/my-api-collections || exit
        git pull
        cd - > /dev/null || exit
    fi
}

work_api_collections() {
    : # no work-specific api collections yet
}

personal_api_collections() {
    : # no personal-specific api collections yet
}

setup_api_collections() {
    # shellcheck source=helpers.sh
    source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
    ensure_device_type

    run_for_device general_api_collections work_api_collections personal_api_collections
}

setup_api_collections_clean_up() {
    echo "${COLOR_GREEN}Setup collections clean up - coming feature...${COLOR_RESET}"
}
