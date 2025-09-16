#!/bin/bash

# API Terminal using shared utilities
# shellcheck source=./terminal_utils.sh
source "$(dirname "$0")/terminal_utils.sh"

# Setup this terminal instance
setup_terminal_instance "api" "API Terminal"
cd ~/personal/my-collections/ || exit 1

# Last collection management
LAST_COLLECTION_FILE="/tmp/api_terminal_last_collection_$$"
LAST_COLLECTION=""

if [ -f "$LAST_COLLECTION_FILE" ]; then
    LAST_COLLECTION=$(cat "$LAST_COLLECTION_FILE")
fi

# Save last selected collection
save_last_collection() {
    echo "$1" > "$LAST_COLLECTION_FILE"
    LAST_COLLECTION="$1"
}

# Collection selection function
show_collection_selection() {
    clear
    echo "🚀 API Terminal - POSTING Collections"
    echo ""
    echo "Available collections:"
    printf '%s\n' */ | sed 's|/$||' | nl -w2 -s". "
    echo ""
    
    if command -v fzf >/dev/null 2>&1; then
        echo "Select with fzf (Ctrl+C to cancel, Enter for llm-service):"
        collection=$(printf '%s\n' */ | sed 's|/$||' | fzf --height=10 --prompt="Collection: " --header="arrows=navigate, Enter=select, Ctrl+C=cancel" 2>/dev/null)
        
        if [ -n "$collection" ]; then
            save_last_collection "$collection"
            clear
            echo "Loading collection: $collection"
            posting --collection ~/personal/my-collections/$collection
        fi
    else
        read -r -p "Enter collection number/name (Enter for llm-service, 'x' to cancel): " choice
        
        if [ "$choice" = "x" ] || [ "$choice" = "X" ]; then
            return
        elif [ -z "$choice" ]; then
            save_last_collection "llm-service"
            clear
            echo "Using default llm-service collection"
            posting --collection ~/personal/my-collections/llm-service
        elif [[ "$choice" =~ ^[0-9]+$ ]]; then
            collection=$(printf '%s\n' */ | sed 's|/$||' | sed -n "${choice}p")
            if [ -n "$collection" ]; then
                save_last_collection "$collection"
                clear
                echo "Loading collection: $collection"
                posting --collection ~/personal/my-collections/$collection
            else
                save_last_collection "llm-service"
                clear
                echo "Invalid choice, using llm-service"
                posting --collection ~/personal/my-collections/llm-service
            fi
        else
            save_last_collection "$choice"
            clear
            echo "Loading collection: $choice"
            posting --collection ~/personal/my-collections/$choice
        fi
    fi
}

# Commit collections changes
commit_collections() {
    clear
    echo "💾 Saving and committing collections to GitHub..."
    cd ~/personal/my-collections/ || return
    
    if git diff --quiet && git diff --cached --quiet; then
        echo "✅ No changes to commit"
    else
        git add .
        commit_msg="Update collections - $(date '+%Y-%m-%d %H:%M:%S')"
        git commit -m "$commit_msg"
        
        echo "📤 Pushing to GitHub..."
        if git push; then
            echo "✅ Successfully saved and pushed to GitHub!"
        else
            echo "❌ Failed to push to GitHub. Check your connection and permissions."
        fi
    fi
    
    echo ""
    echo "Press Enter to continue..."
    read -r
}

# Main menu loop
while true; do
    # Build menu options dynamically
    menu_options=("c) Choose a collection")
    valid_choices="cnq"
    prompt="Choice (c/n/s/q): "
    
    if [ -n "$LAST_COLLECTION" ]; then
        menu_options+=("l) Use last collection ($LAST_COLLECTION)")
        valid_choices="clnq"
        prompt="Choice (c/l/n/s/q): "
    fi
    
    menu_options+=("n) Open new API terminal instance")
    menu_options+=("s) Commit collections changes")
    menu_options+=("q) Quit terminal")
    
    show_menu "API Terminal - Options" "🚀" "${menu_options[@]}"
    choice=$(get_menu_choice "$prompt")
    
    # Handle input silently for invalid choices
    if ! handle_menu_input "$choice" "$valid_choices" true; then
        continue
    fi
    
    case "$(echo "$choice" | tr '[:upper:]' '[:lower:]')" in
        c)
            show_collection_selection
            ;;
        l)
            if [ -n "$LAST_COLLECTION" ]; then
                clear
                echo "Using last collection: $LAST_COLLECTION"
                posting --collection ~/personal/my-collections/$LAST_COLLECTION
            fi
            ;;
        n)
            if [ -n "$LAST_COLLECTION" ]; then
                # Expand the path and escape properly for the new instance
                collection_path="/Users/wchavarria/personal/my-collections/$LAST_COLLECTION"
                return_command="posting --collection \"$collection_path\""
            else
                return_command=""
            fi
            
            open_new_instance \
                "/Users/wchavarria/personal/dotfiles/.config/aerospace/api_terminal.sh" \
                "api_terminal.sh" \
                "API Terminal" \
                "$return_command"
            ;;
        s)
            commit_collections
            ;;
        q)
            quit_terminal
            ;;
    esac
    
    sleep 0.5
done
