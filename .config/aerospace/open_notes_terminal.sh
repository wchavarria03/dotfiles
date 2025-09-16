#!/bin/bash

# Check if Notes Terminal is already running (exact script name)
if pgrep -fx "/bin/bash /Users/wchavarria/personal/dotfiles/.config/aerospace/notes_terminal.sh" > /dev/null; then
    echo "Notes Terminal is already running in workspace 'p'"
    echo "Switch to workspace 'p' to access it"
    exit 0
fi

# Open WezTerm with Notes Terminal and run the inner script
# Launch in background to get process control
/Applications/WezTerm.app/Contents/MacOS/wezterm start --always-new-process /Users/wchavarria/personal/dotfiles/.config/aerospace/notes_terminal.sh &
WEZTERM_PID=$!

# Wait for WezTerm to launch and then focus the specific new window
sleep 1.5

# Use WezTerm CLI to list windows and focus the newest one with our script
/Applications/WezTerm.app/Contents/MacOS/wezterm cli list --format json 2>/dev/null | \
python3 -c "
import json, sys, subprocess, time
try:
    windows = json.load(sys.stdin)
    # Find the most recent window running our notes terminal script
    notes_windows = [w for w in windows if 'notes_terminal.sh' in w.get('cwd', '') or 'Notes Terminal' in w.get('title', '')]
    if notes_windows:
        # Get the most recent one (highest window_id)
        newest_window = max(notes_windows, key=lambda x: x['window_id'])
        # Focus this specific window
        subprocess.run(['/Applications/WezTerm.app/Contents/MacOS/wezterm', 'cli', 'activate-window', '--window-id', str(newest_window['window_id'])], check=True)
except:
    # Fallback to general activation if CLI approach fails
    subprocess.run(['osascript', '-e', 'tell application \"WezTerm\" to activate'])
" 2>/dev/null

wait $WEZTERM_PID
