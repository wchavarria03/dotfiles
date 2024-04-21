#!/usr/bin/env bash

# Function to setup my personal dotfiles repo
setup_dotfiles() {
  echo "${COLOR_GREEN}DOTFILES repo...${COLOR_REST}"
  if [ ! -d ~/.tmux/plugins/tpm ]
  then
    echo "${COLOR_GREEN}- Cloning Tmux tpm repo...${COLOR_REST}"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  else
    echo "${COLOR_GREEN}- Updating Tmux tpm repo...${COLOR_REST}"
    cd ~/.tmux/plugins/tpm
    git pull
  fi
}

setup_dotfiles
