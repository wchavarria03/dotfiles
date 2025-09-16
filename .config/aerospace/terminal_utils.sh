#!/bin/bash

# Terminal Utils Library
# Shared functionality for API and DB terminals

# Setup terminal instance with unique ID and cleanup
setup_terminal_instance() {
    local terminal_type="$1"
    local title="$2"
    
    # Set unique window title
    printf "\033]0;%s ($$)\007" "$title"
    
    # Create unique temp file for this instance (if needed)
    # shellcheck disable=SC2034  # TERMINAL_ID may be used in sourcing scripts
    TERMINAL_ID="${terminal_type}_terminal_$$_$(date +%s)"
    
    # Cleanup function
    cleanup() {
        # Clean up any temp files if they exist
        rm -f "/tmp/${terminal_type}_terminal_last_*_$$" 2>/dev/null
        exit 0
    }
    
    # Handle Ctrl+C properly
    handle_interrupt() {
        clear
        echo "Goodbye!"
        cleanup
    }
    
    # Set traps
    trap cleanup EXIT TERM
    trap handle_interrupt INT
    
    # Process group isolation
    set -m
}

# Generic menu display and input handling
show_menu() {
    local title="$1"
    local icon="$2"
    shift 2
    local options=("$@")
    
    clear
    echo "$icon $title"
    echo ""
    
    # Display options
    for option in "${options[@]}"; do
        echo "  $option"
    done
    echo ""
}

# Generic menu choice handler
get_menu_choice() {
    local prompt="$1"
    read -p "$prompt" choice
    echo "$choice"
}

# Focus new terminal window (reusable focus logic)
focus_new_terminal_window() {
    local script_name="$1"
    local window_title="$2"
    
    (
        sleep 2
        /Applications/WezTerm.app/Contents/MacOS/wezterm cli list --format json 2>/dev/null | \
        python3 -c "
import json, sys, subprocess
try:
    windows = json.load(sys.stdin)
    # Find the most recent terminal window
    terminal_windows = [w for w in windows if '$script_name' in w.get('cwd', '') or '$window_title' in w.get('title', '')]
    if terminal_windows:
        # Get the newest one (highest window_id)
        newest_window = max(terminal_windows, key=lambda x: x['window_id'])
        # Focus this specific window
        subprocess.run(['/Applications/WezTerm.app/Contents/MacOS/wezterm', 'cli', 'activate-window', '--window-id', str(newest_window['window_id'])], check=True)
except:
    pass
" 2>/dev/null
    ) &
}

# Generic new instance handler
open_new_instance() {
    local script_path="$1"
    local script_name="$2"
    local window_title="$3"
    local return_action="$4"
    
    clear
    echo "Opening new terminal instance..."
    
    # Launch new instance
    /Applications/WezTerm.app/Contents/MacOS/wezterm start --always-new-process "$script_path" &
    
    # Focus the new window
    focus_new_terminal_window "$script_name" "$window_title"
    
    echo "New terminal opened!"
    sleep 1
    
    # Execute return action if provided
    if [ -n "$return_action" ]; then
        echo "Returning to previous activity..."
        sleep 1
        eval "$return_action"
    fi
}

# Handle empty input and invalid choices
handle_menu_input() {
    local choice="$1"
    local valid_choices="$2"
    local silent_invalid="${3:-false}"
    
    case "$choice" in
        "")
            # Do nothing for empty input
            return 1
            ;;
        *)
            # Check if choice is in valid choices
            choice_lower="$(echo "$choice" | tr '[:upper:]' '[:lower:]')"
            if [[ "$valid_choices" == *"$choice"* ]] || [[ "$valid_choices" == *"$choice_lower"* ]]; then
                return 0  # Valid choice
            else
                if [ "$silent_invalid" = "true" ]; then
                    return 1  # Invalid but silent
                else
                    echo "Invalid choice. Please select from: $valid_choices"
                    sleep 1
                    return 1
                fi
            fi
            ;;
    esac
}

# Generic quit handler
quit_terminal() {
    clear
    echo "Goodbye!"
    exit 0
}

# Check if command exists
check_command() {
    local cmd="$1"
    local install_instructions="$2"
    
    if command -v "$cmd" >/dev/null 2>&1; then
        return 0
    else
        echo "❌ $cmd not found. Install it with:"
        echo "$install_instructions"
        echo ""
        echo "Press Enter to continue..."
        read
        return 1
    fi
}

# Launch application with error handling
launch_app() {
    local app_name="$1"
    local app_command="$2"
    local install_instructions="$3"
    shift 3
    local app_args="$*"
    
    clear
    echo "Launching $app_name..."
    
    if check_command "$app_command" "$install_instructions"; then
        if [ -n "$app_args" ]; then
            $app_command $app_args || true  # Don't exit on application failure
        else
            $app_command || true  # Don't exit on application failure
        fi
    fi
}
