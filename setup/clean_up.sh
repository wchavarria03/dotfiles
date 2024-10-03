#!/usr/bin/env bash

# Define colors for better output formatting
COLOR_RESET=$(tput sgr0)
COLOR_GREEN=$(tput setaf 2)

# Main function to orchestrate the setup process
clean_up() {
  read -p "Are you sure you want to proceed with the clean up? (y/n): " response

  # Check the user's response
  if [[ $response =~ ^[Nn]?$ ]]; then
    echo "Action aborted."
    exit 1  # Abort script with a non-zero exit status
  fi

  # Loop through all .sh files in the setup directory
  for file in ./*.sh; do
    # Make the file executable
    chmod +x "$file"
    echo "${COLOR_GREEN}Making $file executable...${COLOR_RESET}"
  done

  echo "${COLOR_GREEN}Starting clean up ...${COLOR_RESET}"

  source create_folders.sh
  create_folders_clean_up

  source install_and_update_homebrew.sh
  install_and_update_homebrew_clean_up

  source install_brew_packages.sh
  install_brew_packages_clean_up

  source install_brew_fonts.sh
  install_brew_fonts_clean_up

  source setup_secrets.sh
  setup_secrets_clean_up

  source setup_dotfiles.sh
  setup_dotfiles_clean_up

  source setup_mac_config.sh
  setup_mac_config_clean_up

  # Add more setup steps here
  echo "${COLOR_GREEN}OSX clean up completed.${COLOR_RESET}"
}

# Execute main function
clean_up

