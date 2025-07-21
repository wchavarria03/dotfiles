#!/usr/bin/env bash

# Set up PATH to include common locations for binaries
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Check if Kitty is installed
if ! command -v kitty &>/dev/null; then
  echo "Kitty is not installed or not in the PATH."
  exit 1
fi

# Launch the built-in quick access terminal kitten
kitten quick-access-terminal 
