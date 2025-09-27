#!/usr/bin/env zsh

# Quick Notes Terminal Script - similar to db_terminal.sh approach

# Set the quick notes file path in iCloud notes directory
NOTES_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/notes"
QUICK_NOTES_FILE="$NOTES_DIR/quick-notes.md"

# Ensure notes directory exists
if [ ! -d "$NOTES_DIR" ]; then
    echo "iCloud notes directory not found, creating fallback..."
    mkdir -p "$HOME/notes"
    NOTES_DIR="$HOME/notes"
    QUICK_NOTES_FILE="$NOTES_DIR/quick-notes.md"
fi

# Set terminal title
printf '\033]0;Quick Notes Terminal\007'

# Change to notes directory and open the quick notes file
cd "$NOTES_DIR" || exit 1
# Notes mode functionality now integrated into main Neovim config

echo '📝 Quick Notes - Opening iCloud synced notes...'
nvim "$QUICK_NOTES_FILE"

# Keep the terminal open after nvim exits
echo ""
echo "Quick Notes session ended. Terminal will remain open."
echo "Close this window or press Ctrl+D to exit."

# Keep shell running
exec "$SHELL"
