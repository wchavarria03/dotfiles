#!/usr/bin/env bash

general_fonts() {
    local fonts=(
        font-jetbrains-mono-nerd-font # includes nerd font icons used in wezterm tabbar
    )

    for font in "${fonts[@]}"; do
        if brew list --cask "$font" &>/dev/null; then
            echo "${COLOR_GREEN}-- $font already installed.${COLOR_RESET}"
        else
            echo "${COLOR_GREEN}-- Installing $font...${COLOR_RESET}"
            brew install --cask "$font"
        fi
    done
}

work_fonts() {
    : # no work-specific fonts yet
}

personal_fonts() {
    : # no personal-specific fonts yet
}

install_brew_fonts() {
    # shellcheck source=helpers.sh
    source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
    ensure_device_type

    run_for_device general_fonts work_fonts personal_fonts
}

install_brew_fonts_clean_up() {
    echo "${COLOR_GREEN}Install Brew fonts clean up - coming feature...${COLOR_RESET}"
}
