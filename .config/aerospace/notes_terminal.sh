#!/usr/bin/env zsh

# Notes Terminal - open vault root for browsing existing notes

# Set terminal title
printf '\033]0;Notes Terminal\007'

NOTES_DIR="$HOME/personal/notes"

cd "$NOTES_DIR" || exit 1

clear
echo "📝 Notes Terminal - Opening vault..."
nvim .
