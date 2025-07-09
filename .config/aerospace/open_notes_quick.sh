#!/usr/bin/env bash

# Check if Kitty is installed
if ! command -v kitty &>/dev/null; then
  echo "Kitty is not installed or not in the PATH."
  exit 1
fi

# Launch the built-in quick access terminal kitten
kitten quick-access-terminal 