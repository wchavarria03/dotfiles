#!/usr/bin/env bash

# Function to setup my personal dotfiles repo
setup_dotfiles() {
  if [ ! -d ~/personal/dotfiles/ ]
  then
    echo "${COLOR_GREEN}-- Cloning dotfiles repo...${COLOR_REST}"
    git clone https://github.com/wchavarria03/dotfiles ~/personal/dotfiles
  else
    echo "${COLOR_GREEN}- Updating dotfiles repo...${COLOR_REST}"
    cd ~/personal/dotfiles || exit
    git pull
    cd - > /dev/null || exit  # Return to the original directory, suppressing output
  fi
}

setup_dotfiles_clean_up() {
  echo "${COLOR_GREEN}Setup dotfiles clean up - coming feature...${COLOR_RESET}"
}
