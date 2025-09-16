#!/bin/bash

# Notes Terminal using shared utilities
# shellcheck source=./terminal_utils.sh
source "$(dirname "$0")/terminal_utils.sh"

# Setup this terminal instance
setup_terminal_instance "notes" "Notes Terminal"

# Navigate to notes directory
if [ -d "$HOME/Library/Mobile Documents/com~apple~CloudDocs/notes" ]; then
    cd "$HOME/Library/Mobile Documents/com~apple~CloudDocs/notes" || exit 1
elif [ -d "$HOME/notes" ]; then
    cd "$HOME/notes" || exit 1
else
    mkdir -p "$HOME/notes" && cd "$HOME/notes" || exit 1
fi

# Set notes mode for Neovim
export NVIM_MODE=notes

# Launch Neovim with todos.md immediately
clear
echo "📝 Notes Terminal - Opening todos.md..."
nvim todos.md

# After Neovim exits, show a simple menu
while true; do
    show_menu "Notes Terminal - Options" "📝" \
        "e) Edit todos.md again" \
        "n) Open Neovim file browser" \
        "q) Quit terminal"
    
    choice=$(get_menu_choice "Choice (e/n/q): ")
    
    # Handle input silently for invalid choices
    if ! handle_menu_input "$choice" "enq" true; then
        continue
    fi
    
    case "$(echo "$choice" | tr '[:upper:]' '[:lower:]')" in
        e)
            clear
            echo "Opening todos.md..."
            nvim todos.md
            ;;
        n)
            clear
            echo "Opening Neovim file browser..."
            nvim .
            ;;
        q)
            quit_terminal
            ;;
    esac
    
    sleep 0.5
done
