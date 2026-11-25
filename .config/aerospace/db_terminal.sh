#!/bin/bash

# DB Terminal using shared utilities
# shellcheck source=./terminal_utils.sh
source "$(dirname "$0")/terminal_utils.sh"

export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Setup this terminal instance
setup_terminal_instance "db" "DB Terminal"
cd ~ || exit 1

# Launch nvim with DBUI immediately on startup
clear
echo "🗄️  DB Terminal - Launching nvim + DBUI..."
nvim -c "DBUI"

# Main menu loop after nvim exits
while true; do
    show_menu "DB Terminal - DBUI" "🗄️" \
        "l) Launch nvim + DBUI again" \
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
            echo "🗄️  Launching nvim + DBUI..."
            nvim -c "DBUI"
            ;;
        n)
            open_new_instance \
                "/Users/wchavarria/personal/dotfiles/.config/aerospace/db_terminal.sh" \
                "db_terminal.sh" \
                "DB Terminal" \
                "nvim -c 'DBUI'"
            ;;
        q)
            quit_terminal
            ;;
    esac
    
    # Brief pause before returning to menu
    sleep 0.5
done
