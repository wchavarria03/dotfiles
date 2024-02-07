#!/usr/bin/env bash


# Function to install brew fonts
install_brew_fonts() {
  local fonts=(
    font-meslo-for-powerline
  )

  for font in "${fonts[@]}"; do
    if brew info "$font" &>/dev/null; then
        echo "${COLOR_GREEN}$font already installed.${COLOR_RESET}"
    else
        echo "${COLOR_GREEN}Installing $font...${COLOR_RESET}"
        brew install "$font"
    fi
  done
}

install_brew_fonts
