#!/usr/bin/env zsh
# Usage: launch_terminal.sh <script> <title>

SCRIPT=$1
TITLE=$2
WEZTERM=/Applications/WezTerm.app/Contents/MacOS/wezterm

# Process running + window visible in aerospace = already open, nothing to do
if pgrep -f "wezterm.*$SCRIPT" > /dev/null 2>&1; then
    aerospace list-windows --all 2>/dev/null | grep -qF "$TITLE" && exit 0
fi

nohup $WEZTERM start --always-new-process "$SCRIPT" > /dev/null 2>&1 & disown 2>/dev/null; true
