#!/usr/bin/env bash

# Function to setup my API collections repo
setup_api_collections() {
  if [ ! -d ~/personal/my-api-collections/ ]
  then
    echo "${COLOR_GREEN}-- Cloning collections repo...${COLOR_REST}"
    git clone https://github.com/wchavarria03/my-api-collections ~/personal/my-api-collections
  else
    echo "${COLOR_GREEN}-- Updating collections repo...${COLOR_REST}"
    cd ~/personal/my-api-collections
    git pull
    cd - > /dev/null  # Return to the original directory, suppressing output
  fi
}

setup_api_collections_clean_up() {
  echo "${COLOR_GREEN}Setup collections clean up - coming feature...${COLOR_RESET}"
}
