#!/usr/bin/env zsh

# Quick Notes Terminal - capture to inbox for later processing into PARA

NOTES_DIR="$HOME/personal/notes"
QUICK_NOTES_FILE="$NOTES_DIR/0-Inbox/quick-notes.md"

# Set terminal title
printf '\033]0;Quick Notes Terminal\007'

cd "$NOTES_DIR" || exit 1

echo '📝 Quick Notes - Opening inbox capture...'
nvim "$QUICK_NOTES_FILE"

echo ""
echo "Quick Notes session ended. Terminal will remain open."
echo "Close this window or press Ctrl+D to exit."

exec "$SHELL"
