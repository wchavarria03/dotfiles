#!/usr/bin/env bash

# Check if Kitty is installed
if ! command -v kitty &>/dev/null; then
  echo "Kitty is not installed or not in the PATH."
  exit 1
fi

# Check if there's already a Kitty instance with the notes instance group
# We'll check for existing Kitty processes with the notes_dedicated instance group
if pgrep -f "kitty.*notes_dedicated" > /dev/null; then
  # Focus the existing window by bringing the Kitty app to front
  # This will focus the most recently used Kitty window
  osascript -e 'tell application "Kitty" to activate' 2>/dev/null
  exit 0
fi

# Use the same shell configuration as kitty.conf to ensure consistent environment
kitty --single-instance --instance-group=notes_dedicated zsh --login -c "export PATH=\"/opt/homebrew/bin:\$PATH\" && export NVIM_APPNAME=nvim-notes && source \"\$HOME/.config/zsh/.zshrc\" && cd \"\$HOME/Library/Mobile Documents/com~apple~CloudDocs/notes\" && nvim todos.md" &
