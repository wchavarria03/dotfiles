#!/usr/bin/env bash

# Function to setup my personal dotfiles repo
setup_tmux_tpm() {
  echo "${COLOR_GREEN}DOTFILES repo...${COLOR_REST}"
  if [ ! -d ~/code/tmux-plugins/tpm/ ]
  then
    echo "${COLOR_GREEN}- Cloning Tmux tpm repo...${COLOR_REST}"
    git clone https://github.com/tmux-plugins/tpm ~/code/tmux-plugins/tpm
  else
    echo "${COLOR_GREEN}- Updating Tmux tpm repo...${COLOR_REST}"
    cd ~/code/tmux-plugins/tpm
    git pull
    cd - > /dev/null  # Return to the original directory, suppressing output
  fi
}

setup_tmux_tpm
