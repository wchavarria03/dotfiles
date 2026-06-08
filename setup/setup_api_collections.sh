#!/usr/bin/env bash

# Function to setup my API collections repo
setup_api_collections() {
  if [ ! -d ~/personal/my-api-collections/ ]
  then
    echo "${COLOR_GREEN}-- Cloning collections repo...${COLOR_RESET}"
    git clone git@github.com:wchavarria03/my-api-collections.git ~/personal/my-api-collections
  else
    echo "${COLOR_GREEN}-- Updating collections repo...${COLOR_RESET}"
    cd ~/personal/my-api-collections || exit
    git pull
    cd - > /dev/null || exit  # Return to the original directory, suppressing output
  fi
}

setup_api_collections_clean_up() {
  echo "${COLOR_GREEN}Setup collections clean up - coming feature...${COLOR_RESET}"
}
