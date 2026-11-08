#!/bin/bash

# Notes Nvim using shared utilities
# shellcheck source=./terminal_utils.sh
source "$(dirname "$0")/terminal_utils.sh"

setup_terminal_instance "notes" "Notes Nvim"
cd ~/personal/notes || exit 1
exec nvim second-brain/home.md
