#!/bin/bash

# Notes Capture using shared utilities
# shellcheck source=./terminal_utils.sh
source "$(dirname "$0")/terminal_utils.sh"

setup_terminal_instance "capture" "Notes Capture"
cd ~/personal/notes || exit 1
exec nvim +'normal Go' +startinsert second-brain/ideas_todos.md
