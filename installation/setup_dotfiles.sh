#!/usr/bin/env bash

# Function to setup my personal dotfiles repo
setup_dotfiles() {
  if [ ! -d ~/code/dotfiles/ ]
  then
      echo "${COLOR_GREEN}*Cloning dotfiles repo...${COLOR_REST}"
      cd ~/code
      git clone https://github.com/wchavarria03/dotfiles
  else
      echo "${COLOR_GREEN}Updating dotfiles repo...${COLOR_REST}"
      cd ~/code/dotfiles
      git pull
  fi
}

setup_dotfiles
