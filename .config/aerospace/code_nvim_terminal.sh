#!/bin/bash

# Code Nvim using shared utilities
# shellcheck source=./terminal_utils.sh
source "$(dirname "$0")/terminal_utils.sh"

setup_terminal_instance "code" "Code Nvim"
cd ~ || exit 1
exec nvim
