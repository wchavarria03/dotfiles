#!/usr/bin/env bash

# Check if Wezterm is installed
if ! command -v wezterm &> /dev/null; then
    echo "Wezterm is not installed or not in the PATH."
    exit 1
fi

# Check if Wezterm is already running
wezterm start --cwd ~/personal/notes --class wezterm_notes -- notes zsh -c "nvim" > /dev/null 2>&1 &

# Move to the notes workspace
aerospace workspace 5

sleep 1
aerospace focus left
