#!/bin/bash

# Quick Notes Terminal - Using the same approach as DB terminal

# Check if Quick Notes Terminal is already running (exact script name)
if pgrep -fx "/bin/bash /Users/wchavarria/personal/dotfiles/.config/aerospace/quick_notes_terminal.sh" > /dev/null; then
    echo "Quick Notes is already open"
    
    # Find the WezTerm window running Quick Notes
    EXISTING_WINDOW_ID=$(aerospace list-windows --all --format "%{window-id} %{app-name} %{window-title}" | grep "WezTerm" | grep -i "quick.*notes" | head -1 | cut -d' ' -f1)
    
    if [ -n "$EXISTING_WINDOW_ID" ]; then
        # Get the current focused workspace
        CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)
        
        # Check if the Quick Notes window is currently focused
        FOCUSED_WINDOW_ID=$(aerospace list-windows --focused --format "%{window-id}")
        
        if [ "$EXISTING_WINDOW_ID" = "$FOCUSED_WINDOW_ID" ]; then
            # Quick Notes is focused, so unfocus it by focusing another window (toggle off)
            echo "Quick Notes is focused, unfocusing by focusing another window"
            
            # Find another window in the current workspace to focus
            OTHER_WINDOW_ID=$(aerospace list-windows --workspace "$CURRENT_WORKSPACE" --format "%{window-id} %{app-name}" | grep -v "^$EXISTING_WINDOW_ID " | head -1 | cut -d' ' -f1)
            
            if [ -n "$OTHER_WINDOW_ID" ]; then
                echo "Focusing window $OTHER_WINDOW_ID instead"
                aerospace focus --window-id "$OTHER_WINDOW_ID"
            else
                echo "No other windows found, focusing next window in workspace"
                aerospace focus dfs-next
            fi
            exit 0
        else
            # Quick Notes exists but not focused, so bring it to current workspace (toggle on)
            echo "Moving existing Quick Notes window to workspace $CURRENT_WORKSPACE"
            
            # Move existing window to current workspace
            aerospace move-node-to-workspace "$CURRENT_WORKSPACE" --window-id "$EXISTING_WINDOW_ID"
            
            # Make it floating for overlay behavior
            aerospace layout floating --window-id "$EXISTING_WINDOW_ID"
            
            # Focus the window to bring it to front
            aerospace focus --window-id "$EXISTING_WINDOW_ID"
            
            echo "Existing Quick Notes moved to workspace $CURRENT_WORKSPACE, floating, and focused"
            exit 0
        fi
    fi
fi

# Launch WezTerm with Quick Notes terminal script (same approach as DB terminal)
/Applications/WezTerm.app/Contents/MacOS/wezterm \
  --config-file /Users/wchavarria/personal/dotfiles/.config/wezterm/quick_terminal.lua \
  start --always-new-process \
  /Users/wchavarria/personal/dotfiles/.config/aerospace/quick_notes_terminal.sh &

# Wait for WezTerm to launch and get the window
sleep 1

# Get the current focused workspace
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

# Find and configure the Quick Notes window
WINDOW_ID=$(aerospace list-windows --all --format "%{window-id} %{app-name}" | grep "WezTerm" | tail -1 | cut -d' ' -f1)

if [ -n "$WINDOW_ID" ]; then
  echo "Moving new window $WINDOW_ID to workspace $CURRENT_WORKSPACE"
  aerospace move-node-to-workspace "$CURRENT_WORKSPACE" --window-id "$WINDOW_ID"
  
  # Make it floating for overlay behavior
  aerospace layout floating --window-id "$WINDOW_ID"
  
  # Focus the window to bring it to front
  aerospace focus --window-id "$WINDOW_ID"
  
  echo "Quick Notes opened on workspace $CURRENT_WORKSPACE, floating, and focused"
else
  echo "Could not find Quick Notes window"
fi
