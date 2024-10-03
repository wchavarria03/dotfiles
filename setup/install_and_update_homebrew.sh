#!/usr/bin/env bash

# Function to install Homebrew if not already installed
install_and_update_homebrew() {
    if ! command -v brew &>/dev/null; then
        echo "${COLOR_GREEN}-- Installing Homebrew...${COLOR_RESET}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "${COLOR_GREEN}-- Homebrew already installed.${COLOR_RESET}"
    fi

    echo "${COLOR_GREEN}-- Updating homebrew...${COLOR_REST}"
    brew update

    echo "${COLOR_GREEN}-- Upgrading homebrew...${COLOR_REST}"
    brew upgrade
}

install_and_update_homebrew_clean_up() {
  echo "${COLOR_GREEN}Install and update Homebrew clean up - coming feature...${COLOR_RESET}"
}
