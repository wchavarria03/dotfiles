#!/usr/bin/env bash

# Function to install brew fonts
install_brew_fonts() {
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

install_brew_fonts_clean_up() {
  echo "${COLOR_GREEN}Install Brew fonts clean up - coming feature...${COLOR_RESET}"
}
