#!/bin/bash

# Quick Notes scratchpad — single floating instance that moves between workspaces.
# quick_terminal.lua locks the window title to "Quick Notes Terminal" via the
# format-window-title hook, so aerospace can always identify it reliably.

WINDOW_TITLE="Quick Notes Terminal"
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

EXISTING_ID=$(aerospace list-windows --all --format "%{window-id} %{window-title}" 2>/dev/null \
    | grep "$WINDOW_TITLE" | head -1 | awk '{print $1}')

if [ -n "$EXISTING_ID" ]; then
    FOCUSED_ID=$(aerospace list-windows --focused --format "%{window-id}" 2>/dev/null)

    if [ "$EXISTING_ID" = "$FOCUSED_ID" ]; then
        # Currently focused — send to hidden scratch workspace (no keybinding, invisible during navigation)
        aerospace move-node-to-workspace scratch --window-id "$EXISTING_ID"
    else
        # Exists but not focused — bring to current workspace as floating overlay.
        # layout only applies to the focused window, so focus before floating.
        aerospace move-node-to-workspace "$CURRENT_WORKSPACE" --window-id "$EXISTING_ID"
        aerospace focus --window-id "$EXISTING_ID"
        aerospace layout floating
    fi
else
    # No window found — launch a new one and detect it by title
    /Applications/WezTerm.app/Contents/MacOS/wezterm \
        --config-file /Users/wchavarria/personal/dotfiles/.config/wezterm/quick_terminal.lua \
        start --always-new-process \
        /Users/wchavarria/personal/dotfiles/.config/aerospace/quick_notes_terminal.sh &

    sleep 1

    NEW_ID=$(aerospace list-windows --all --format "%{window-id} %{window-title}" 2>/dev/null \
        | grep "$WINDOW_TITLE" | head -1 | awk '{print $1}')

    if [ -n "$NEW_ID" ]; then
        aerospace move-node-to-workspace "$CURRENT_WORKSPACE" --window-id "$NEW_ID"
        aerospace focus --window-id "$NEW_ID"
        aerospace layout floating
    else
        echo "Could not find Quick Notes window"
    fi
fi
