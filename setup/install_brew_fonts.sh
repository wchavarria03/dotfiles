#!/usr/bin/env bash

install_brew_fonts() {
    # shellcheck source=helpers.sh
    source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
    ensure_device_type
    load_device_script

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

    install_device_fonts
}

install_brew_fonts_clean_up() {
    echo "${COLOR_GREEN}Install Brew fonts clean up - coming feature...${COLOR_RESET}"
}
