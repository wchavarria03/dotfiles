#!/usr/bin/env bash

# Function to setup my personal dotfiles repo
setup_dotfiles() {
  echo "${COLOR_GREEN}DOTFILES repo...${COLOR_REST}"
  if [ ! -d ~/code/dotfiles/ ]
  then
    echo "${COLOR_GREEN}- Cloning dotfiles repo...${COLOR_REST}"
    git clone https://github.com/wchavarria03/dotfiles ~/code
  else
    echo "${COLOR_GREEN}- Updating dotfiles repo...${COLOR_REST}"
    cd ~/code/dotfiles
    git pull
    cd - > /dev/null  # Return to the original directory, suppressing output
  fi
}
