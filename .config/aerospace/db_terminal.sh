#!/bin/bash

# DB Terminal using shared utilities
source "$(dirname "$0")/terminal_utils.sh"

# Setup this terminal instance
setup_terminal_instance "db" "DB Terminal"
cd ~

# Launch LazySQL immediately on startup
clear
echo "🗄️  DB Terminal - Launching LazySQL..."
if command -v lazysql >/dev/null 2>&1; then
    lazysql || true  # Don't exit if LazySQL returns non-zero
else
    echo "❌ LazySQL not found. Install it with:"
    echo "   go install github.com/jorgerojas26/lazysql@latest"
    echo "   Or: brew install lazysql"
    echo ""
    echo "Press Enter to continue..."
    read
fi

# Main menu loop after LazySQL exits
while true; do
    show_menu "DB Terminal - LazySQL" "🗄️" \
        "l) Launch LazySQL again" \
        "n) Open new DB terminal instance" \
        "q) Quit terminal"
    
    choice=$(get_menu_choice "Choice (l/n/q): ")
    
    # Handle input
    if ! handle_menu_input "$choice" "lnq" false; then
        continue
    fi
    
    case "$(echo "$choice" | tr '[:upper:]' '[:lower:]')" in
        l)
            clear
            echo "🗄️  Launching LazySQL..."
            if command -v lazysql >/dev/null 2>&1; then
                lazysql || true  # Don't exit if LazySQL returns non-zero
            else
                echo "❌ LazySQL not found. Install it with:"
                echo "   go install github.com/jorgerojas26/lazysql@latest"
                echo "   Or: brew install lazysql"
                echo ""
                echo "Press Enter to continue..."
                read
            fi
            ;;
        n)
            open_new_instance \
                "/Users/wchavarria/personal/dotfiles/.config/aerospace/db_terminal.sh" \
                "db_terminal.sh" \
                "DB Terminal" \
                "launch_app 'LazySQL' 'lazysql' 'go install github.com/jorgerojas26/lazysql@latest'"
            ;;
        q)
            quit_terminal
            ;;
    esac
    
    # Brief pause before returning to menu
    sleep 0.5
done
