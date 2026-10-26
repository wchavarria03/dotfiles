#!/usr/bin/env zsh
# Shared helpers for the Emacs launchers.
# One Emacs daemon per role ("notes", "code"). config.el titles every frame
# "<Role> Emacs — <buffer>", so aerospace can route frames by title.

for c in /opt/homebrew/bin/emacsclient /usr/local/bin/emacsclient \
         /Applications/Emacs.app/Contents/MacOS/bin/emacsclient; do
    [[ -x $c ]] && EMACSCLIENT=$c && break
done
for e in /opt/homebrew/bin/emacs /usr/local/bin/emacs \
         /Applications/Emacs.app/Contents/MacOS/Emacs; do
    [[ -x $e ]] && EMACS=$e && break
done

# Start the named daemon unless it already answers. Blocks until it is ready.
ensure_daemon() {
    local name=$1
    "$EMACSCLIENT" -s "$name" -e t >/dev/null 2>&1 && return 0
    "$EMACS" --daemon="$name" >/dev/null 2>&1
}

# Window id of the first window whose title starts with $1.
window_id() {
    aerospace list-windows --all --format '%{window-id}|%{window-title}' 2>/dev/null \
        | grep -F "|$1" | head -1 | cut -d'|' -f1
}

# Wait up to ~3 s for a window titled $1 to appear; print its id.
wait_for_window() {
    local id
    for _ in {1..30}; do
        id=$(window_id "$1")
        [[ -n $id ]] && { echo "$id"; return 0; }
        sleep 0.1
    done
    return 1
}

# Open the role's frame on <workspace> unless it is already open.
# The keybinding switches workspace first, so an open frame needs nothing,
# same as launch_terminal.sh. A new frame is moved explicitly because Emacs
# can set its title after aerospace's on-window-detected rules have run.
# Usage: open_frame_on <daemon> <title prefix> <workspace> [emacsclient args...]
open_frame_on() {
    local name=$1 title=$2 ws=$3; shift 3
    [[ -n $(window_id "$title") ]] && return 0
    "$EMACSCLIENT" -s "$name" -c -n "$@" >/dev/null 2>&1
    local id
    id=$(wait_for_window "$title") || return 1
    aerospace move-node-to-workspace "$ws" --window-id "$id"
    aerospace focus --window-id "$id"
}
