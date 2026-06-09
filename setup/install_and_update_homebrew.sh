#!/usr/bin/env bash

# Function to install Homebrew if not already installed
install_and_update_homebrew() {
    if ! command -v brew &>/dev/null; then
        echo "${COLOR_GREEN}-- Installing Homebrew...${COLOR_RESET}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "${COLOR_GREEN}-- Homebrew already installed.${COLOR_RESET}"
    fi

    echo "${COLOR_GREEN}-- Updating homebrew...${COLOR_RESET}"
    brew update

    echo "${COLOR_GREEN}-- Trusting third-party taps...${COLOR_RESET}"
    brew tap FelixKratz/formulae 2>/dev/null || true
    brew tap nikitabobko/tap 2>/dev/null || true
    brew trust FelixKratz/formulae 2>/dev/null || true
    brew trust nikitabobko/tap 2>/dev/null || true

    echo "${COLOR_GREEN}-- Upgrading homebrew...${COLOR_RESET}"
    brew upgrade
}

install_and_update_homebrew_clean_up() {
  echo "${COLOR_GREEN}Install and update Homebrew clean up - coming feature...${COLOR_RESET}"
}
