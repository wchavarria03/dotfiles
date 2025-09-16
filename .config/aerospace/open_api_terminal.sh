#!/bin/bash

# Check if API Terminal is already running
if pgrep -f "api_terminal.sh" > /dev/null; then
    echo "API Terminal is already running in workspace 'a'"
    echo "Switch to workspace 'a' to access it, or use the 'n' option within the terminal to open a new instance"
    exit 0
fi

# Open WezTerm with API Terminal and run the simplified inner script
# Launch in background to get process control
/Applications/WezTerm.app/Contents/MacOS/wezterm start --always-new-process /Users/wchavarria/personal/dotfiles/.config/aerospace/api_terminal.sh &
WEZTERM_PID=$!

# Wait for WezTerm to launch and then focus the specific new window
sleep 1.5

# Use WezTerm CLI to list windows and focus the newest one with our script
/Applications/WezTerm.app/Contents/MacOS/wezterm cli list --format json 2>/dev/null | \
python3 -c "
import json, sys, subprocess, time
try:
    windows = json.load(sys.stdin)
    # Find the most recent window running our API terminal script
    api_windows = [w for w in windows if 'api_terminal.sh' in w.get('cwd', '') or 'API Terminal' in w.get('title', '')]
    if api_windows:
        # Get the most recent one (highest window_id)
        newest_window = max(api_windows, key=lambda x: x['window_id'])
        # Focus this specific window
        subprocess.run(['/Applications/WezTerm.app/Contents/MacOS/wezterm', 'cli', 'activate-window', '--window-id', str(newest_window['window_id'])], check=True)
except:
    # Fallback to general activation if CLI approach fails
    subprocess.run(['osascript', '-e', 'tell application \"WezTerm\" to activate'])
" 2>/dev/null

wait $WEZTERM_PID
