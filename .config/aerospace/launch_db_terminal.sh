#!/usr/bin/env zsh

# Check if DB Terminal is already running - if so, focus it
if pgrep -f "db_terminal.sh" > /dev/null 2>&1; then
    # Focus the existing DB Terminal
    /Applications/WezTerm.app/Contents/MacOS/wezterm cli list --format json 2>/dev/null | \
    python3 -c "
import json, sys, subprocess
try:
    windows = json.load(sys.stdin)
    db_windows = [w for w in windows if 'DB Terminal' in w.get('title', '')]
    if db_windows:
        newest_window = max(db_windows, key=lambda x: x['window_id'])
        subprocess.run(['/Applications/WezTerm.app/Contents/MacOS/wezterm', 'cli', 'activate-window', '--window-id', str(newest_window['window_id'])], check=True)
except:
    subprocess.run(['osascript', '-e', 'tell application \"WezTerm\" to activate'])
" 2>/dev/null
    exit 0
fi

# Launch new DB Terminal
/Applications/WezTerm.app/Contents/MacOS/wezterm start --always-new-process /Users/wchavarria/personal/dotfiles/.config/aerospace/db_terminal.sh &
WEZTERM_PID=$!

# Wait for WezTerm to launch and Aerospace to move it to workspace d
sleep 2

# Focus the DB Terminal window (it should be in workspace d due to Aerospace rule)
/Applications/WezTerm.app/Contents/MacOS/wezterm cli list --format json 2>/dev/null | \
python3 -c "
import json, sys, subprocess, time
try:
    windows = json.load(sys.stdin)
    db_windows = [w for w in windows if 'DB Terminal' in w.get('title', '')]
    if db_windows:
        newest_window = max(db_windows, key=lambda x: x['window_id'])
        window_id = str(newest_window['window_id'])
        
        # Use Aerospace to focus the window in workspace d
        subprocess.run(['aerospace', 'workspace', 'd'])
        time.sleep(0.3)
        
        # Then activate the specific WezTerm window
        subprocess.run(['/Applications/WezTerm.app/Contents/MacOS/wezterm', 'cli', 'activate-window', '--window-id', window_id])
        time.sleep(0.2)
        
        # Bring WezTerm to front
        subprocess.run(['osascript', '-e', 'tell application \"WezTerm\" to activate'])
except:
    # Minimal fallback: just ensure we're in workspace d
    subprocess.run(['aerospace', 'workspace', 'd'])
" 2>/dev/null

wait $WEZTERM_PID
