#!/usr/bin/env bash

# Function to setup my personal secrets repo
setup_secrets() {
  echo "${COLOR_GREEN}SECRETS repo...${COLOR_REST}"

  if [ ! -d ~/code/secrets/ ]
  then
    echo "${COLOR_GREEN}- Cloning secrets repo...${COLOR_REST}"
    git clone https://github.com/wchavarria03/secrets ~/code
  else
    echo "${COLOR_GREEN}- Updating secrets repo...${COLOR_REST}"
    pushd
    cd ~/code/secrets
    git pull
    popd
  fi
}

setup_secrets