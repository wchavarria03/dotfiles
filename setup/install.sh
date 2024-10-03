#!/usr/bin/env bash
#
# Bootstrap script for setting up a new OSX machine
#
# This script should be idempotent so it can be run multiple times.
#
# Notes:
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading: - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

# Define colors for better output formatting
COLOR_RESET=$(tput sgr0)
COLOR_GREEN=$(tput setaf 2)

# Main function to orchestrate the setup process
main() {
  # Loop through all .sh files in the installation directory
  echo "${COLOR_GREEN}******************************${COLOR_RESET}"
  echo "${COLOR_GREEN}**** Installation script  ****${COLOR_RESET}"
  echo "${COLOR_GREEN}******************************${COLOR_RESET}"

  echo "${COLOR_GREEN}******** Stage 1 - Prep install files********${COLOR_RESET}"
  for file in ./*.sh; do
    # Make the file executable
    chmod +x "$file"
    echo "${COLOR_GREEN}- Making $file executable...${COLOR_RESET}"
  done

  echo " "
  echo "${COLOR_GREEN}******** Stage 2- Prep folders and brew ********${COLOR_RESET}"
  echo "${COLOR_GREEN}- Create folders${COLOR_RESET}"
  source create_folders.sh

  echo "${COLOR_GREEN}- Brew install and update${COLOR_RESET}"
  source install_and_update_homebrew.sh

  echo "${COLOR_GREEN}- Brew install packages${COLOR_RESET}"
  source install_brew_packages.sh

  echo "${COLOR_GREEN}- Brew install Fonts${COLOR_RESET}"
  source install_brew_fonts.sh

  echo " "
  echo "${COLOR_GREEN}******** Stage 3- Setup Config Repos ********${COLOR_RESET}"
  echo "${COLOR_GREEN}- Setup SECRETS repo${COLOR_REST}"
  source setup_secrets.sh

  echo "${COLOR_GREEN}- Setup DOTFILES repo${COLOR_REST}"
  source setup_dotfiles.sh

  echo "${COLOR_GREEN}- Setup NOTES repo${COLOR_REST}"
  source setup_notes.sh


  echo " "
  echo "${COLOR_GREEN}******** Stage 4- Configure MAC ********${COLOR_RESET}"
  echo ${COLOR_GREEN}"- Configuring MAC defaults..${COLOR_REST}"
  source setup_mac_config.sh

  echo "${COLOR_GREEN}******** Stage 3- Completition ********${COLOR_RESET}"
  echo "${COLOR_GREEN} - OSX setup completed.${COLOR_RESET}"
}

# Execute main function
main
