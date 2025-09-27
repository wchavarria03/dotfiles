#!/usr/bin/env zsh

# Simple Notes Terminal - just open nvim in notes directory

# Set terminal title
printf '\033]0;Notes Terminal\007'

# Navigate to notes directory
if [ -d "$HOME/Library/Mobile Documents/com~apple~CloudDocs/notes" ]; then
    cd "$HOME/Library/Mobile Documents/com~apple~CloudDocs/notes" || exit 1
elif [ -d "$HOME/notes" ]; then
    cd "$HOME/notes" || exit 1
else
    mkdir -p "$HOME/notes" && cd "$HOME/notes" || exit 1
fi

# Launch Neovim with todos.md and keep terminal open after exit
clear
echo "📝 Notes Terminal - Opening todos.md..."
nvim todos.md
