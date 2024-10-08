#!/usr/bin/env bash

# Function to setup my personal secrets repo
setup_secrets() {
  if [ ! -d ~/personal/secrets/ ]
  then
    echo "${COLOR_GREEN}-- Cloning secrets repo...${COLOR_REST}"
    git clone https://github.com/wchavarria03/secrets ~/personal/secrets
  else
    echo "${COLOR_GREEN}-- Updating secrets repo...${COLOR_REST}"
    cd ~/personal/secrets
    git pull
    cd - > /dev/null  # Return to the original directory, suppressing output
  fi
}

setup_secrets_clean_up() {
  echo "${COLOR_GREEN}Setup secrets clean up - coming feature...${COLOR_RESET}"
}
