#!/usr/bin/env bash
#
# Bootstrap script for setting up a new OSX machine
#
# This script should be idempotent so it can be run multiple times.
#
# Notes:
#
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
    echo "${COLOR_GREEN}Starting OSX setup...${COLOR_RESET}"
    source create_folders.sh
    source install_and_update_homebrew.sh
    source install_brew_packages.sh
    source install_brew_fonts.sh
    #source setup_dotfiles.sh
    #source setup_tmux_tpm.sh
    source setup_symblinks.sh
    source setup_mac_config.sh

    # Add more setup steps here
    echo "${COLOR_GREEN}OSX setup completed.${COLOR_RESET}"
}

# Execute main function
main
