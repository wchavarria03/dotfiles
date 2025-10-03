#!/bin/bash

# Ensure uvx is available in PATH
export PATH="$HOME/.config/local/bin:$PATH"

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

# Last environment management
LAST_ENV_FILE="/tmp/api_terminal_last_env_$$"
LAST_ENV=""

if [ -f "$LAST_ENV_FILE" ]; then
    LAST_ENV=$(cat "$LAST_ENV_FILE")
fi

# Save last selected collection
save_last_collection() {
    echo "$1" > "$LAST_COLLECTION_FILE"
    LAST_COLLECTION="$1"
}

# Save last selected environment
save_last_env() {
    echo "$1" > "$LAST_ENV_FILE"
    LAST_ENV="$1"
}

# Environment selection function
select_environment() {
    local collection="$1"
    local collection_path="$HOME/personal/my-collections/$collection"

    # Find all .env files in the collection directory
    local env_files=()
    while IFS= read -r -d '' file; do
        env_files+=("$(basename "$file")")
    done < <(find "$collection_path" -maxdepth 1 -name "*.env" -print0 2>/dev/null)

    # Count env files
    local env_count=${#env_files[@]}

    # No env files found
    if [ "$env_count" -eq 0 ]; then
        echo "none"
        return
    fi

    # Only one env file - auto-select it
    if [ "$env_count" -eq 1 ]; then
        local env_name="${env_files[0]%.env}"  # Remove .env extension
        echo "$env_name"
        return
    fi

    # Multiple env files - let user choose
    echo "" >&2

    # Build list of available env names
    local env_names=""
    for env_file in "${env_files[@]}"; do
        if [ -z "$env_names" ]; then
            env_names="${env_file%.env}"
        else
            env_names="$env_names, ${env_file%.env}"
        fi
    done

    echo "🌍 Available environments: $env_names" >&2
    echo "" >&2

    local i=1
    for env_file in "${env_files[@]}"; do
        echo "  $i) ${env_file%.env}" >&2
        ((i++))
    done
    echo "  $i) none (no environment file)" >&2

    echo "" >&2
    read -r -p "Choose environment (1-$i): " env_choice

    # Handle numeric choice
    if [[ "$env_choice" =~ ^[0-9]+$ ]]; then
        if [ "$env_choice" -eq "$i" ]; then
            echo "none"
        elif [ "$env_choice" -gt 0 ] && [ "$env_choice" -lt "$i" ]; then
            local selected_env="${env_files[$((env_choice-1))]}"
            echo "${selected_env%.env}"
        else
            echo "none"
        fi
    else
        # Try to match by name
        for env_file in "${env_files[@]}"; do
            local env_name="${env_file%.env}"
            if [[ "${env_choice,,}" == "${env_name,,}" ]]; then
                echo "$env_name"
                return
            fi
        done
        echo "none"
    fi
}

# Build posting command with optional env
build_posting_command() {
    local collection="$1"
    local env="$2"
    local collection_path="$HOME/personal/my-collections/$collection"

    if [ "$env" = "none" ] || [ -z "$env" ]; then
        echo "uvx posting --collection $collection_path"
    else
        echo "uvx posting --collection $collection_path --env $collection_path/${env}.env"
    fi
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
        echo "Select with fzf (Ctrl+C to cancel):"
        collection=$(printf '%s\n' */ | sed 's|/$||' | fzf --height=10 --prompt="Collection: " --header="arrows=navigate, Enter=select, Ctrl+C=cancel" 2>/dev/null)

        if [ -n "$collection" ]; then
            save_last_collection "$collection"
            env=$(select_environment "$collection")
            save_last_env "$env"
            clear
            if [ "$env" = "none" ]; then
                echo "Loading collection: $collection (no env)"
            else
                echo "Loading collection: $collection (env: $env)"
            fi
            posting_cmd=$(build_posting_command "$collection" "$env")
            eval "$posting_cmd"
        fi
    else
        read -r -p "Enter collection number/name ('x' to cancel): " choice

        if [ "$choice" = "x" ] || [ "$choice" = "X" ] || [ -z "$choice" ]; then
            return
        elif [[ "$choice" =~ ^[0-9]+$ ]]; then
            collection=$(printf '%s\n' */ | sed 's|/$||' | sed -n "${choice}p")
            if [ -n "$collection" ]; then
                save_last_collection "$collection"
                env=$(select_environment "$collection")
                save_last_env "$env"
                clear
                if [ "$env" = "none" ]; then
                    echo "Loading collection: $collection (no env)"
                else
                    echo "Loading collection: $collection (env: $env)"
                fi
                posting_cmd=$(build_posting_command "$collection" "$env")
                eval "$posting_cmd"
            else
                echo "Invalid choice number"
                sleep 1
                return
            fi
        else
            save_last_collection "$choice"
            env=$(select_environment "$choice")
            save_last_env "$env"
            clear
            if [ "$env" = "none" ]; then
                echo "Loading collection: $choice (no env)"
            else
                echo "Loading collection: $choice (env: $env)"
            fi
            posting_cmd=$(build_posting_command "$choice" "$env")
            eval "$posting_cmd"
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
        if [ -n "$LAST_ENV" ] && [ "$LAST_ENV" != "none" ]; then
            menu_options+=("l) Use last collection ($LAST_COLLECTION - env: $LAST_ENV)")
        else
            menu_options+=("l) Use last collection ($LAST_COLLECTION - no env)")
        fi
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
                if [ "$LAST_ENV" = "none" ] || [ -z "$LAST_ENV" ]; then
                    echo "Using last collection: $LAST_COLLECTION (no env)"
                else
                    echo "Using last collection: $LAST_COLLECTION (env: $LAST_ENV)"
                fi
                posting_cmd=$(build_posting_command "$LAST_COLLECTION" "$LAST_ENV")
                eval "$posting_cmd"
            fi
            ;;
        n)
            if [ -n "$LAST_COLLECTION" ]; then
                # Expand the path and escape properly for the new instance
                collection_path="/Users/wchavarria/personal/my-collections/$LAST_COLLECTION"
                if [ -n "$LAST_ENV" ] && [ "$LAST_ENV" != "none" ]; then
                    return_command="uvx posting --collection \"$collection_path\" --env \"$collection_path/${LAST_ENV}.env\""
                else
                    return_command="uvx posting --collection \"$collection_path\""
                fi
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
