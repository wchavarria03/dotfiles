#!/usr/bin/env bash

# Function to install or update Brew packages
install_packages() {
  local packages=(
    fzf
    git
    gh
    glow # markdown previewer
    npm
    python3
    ripgrep
    nvim
    asdf
    zsh

    # Terminal suggestions
    zsh-syntax-highlighting
    zsh-autosuggestions

    # APPS
    brave-browser
    google-chrome
    gnupg
    iterm2
    notion
    postman
    sequel-ace
    slack
    spectacle
    1password
    1password/tap/1password-cli
  )

  echo "${COLOR_GREEN}Installing/upgrading Brew packages...${COLOR_RESET}"
  for package in "${packages[@]}"; do
      if brew info "$package" &>/dev/null; then
          echo "${COLOR_GREEN}$package already installed.${COLOR_RESET}"
      else
          echo "${COLOR_GREEN}Installing $package...${COLOR_RESET}"
          brew install "$package"
      fi
  done

  echo "${COLOR_GREEN}Installing Brew cask docker...${COLOR_REST}"
  brew install --cask docker

  echo "${COLOR_GREEN}Cleaning up Brew...${COLOR_REST}"
  brew cleanup

  echo "${COLOR_GREEN}Installing brew cask fonts...${COLOR_REST}"
  brew tap homebrew/cask-fonts
}
