#!/usr/bin/env zsh
# Shared helpers for the Emacs launchers.
# One Emacs daemon per role ("notes", "code"). config.el titles every frame
# "<Role> Emacs — <buffer>", so aerospace can route frames by title.
#
# Guards against duplicates:
#   - a daemon lock: only one launcher starts a given daemon; others wait for it
#   - a launch lock: a second key press while a launch is running does nothing
#   - the daemon is asked whether it already has a frame (titles can lag)

for c in /opt/homebrew/bin/emacsclient /usr/local/bin/emacsclient \
         /Applications/Emacs.app/Contents/MacOS/bin/emacsclient; do
    [[ -x $c ]] && EMACSCLIENT=$c && break
done
for e in /opt/homebrew/bin/emacs /usr/local/bin/emacs \
         /Applications/Emacs.app/Contents/MacOS/Emacs; do
    [[ -x $e ]] && EMACS=$e && break
done

LOCK_ROOT="${TMPDIR:-/tmp}"
LAUNCH_LOCK=""
# Script-level trap: in zsh an EXIT trap set inside a function fires when the
# function returns, which would release the launch lock too early.
trap '[[ -n $LAUNCH_LOCK ]] && rmdir "$LAUNCH_LOCK" 2>/dev/null' EXIT

# Start the named daemon unless it already answers. If another launcher is
# starting it, wait for that (up to 30 s) instead of starting a second one.
ensure_daemon() {
    local name=$1 lock="$LOCK_ROOT/emacs-daemon-$1.lock"
    for _ in {1..300}; do
        mkdir "$lock" 2>/dev/null && break
        sleep 0.1
    done
    "$EMACSCLIENT" -s "$name" -e t >/dev/null 2>&1 || "$EMACS" --daemon="$name" >/dev/null 2>&1
    rmdir "$lock" 2>/dev/null
}

# Take the launch lock for $1, or return 1 if another launch holds it.
# A lock older than a minute is from a crashed run and is cleared.
take_launch_lock() {
    local lock="$LOCK_ROOT/emacs-launch-$1.lock"
    find "$lock" -maxdepth 0 -mmin +1 -exec rmdir {} \; 2>/dev/null
    mkdir "$lock" 2>/dev/null || return 1
    LAUNCH_LOCK=$lock
}

# True if daemon $1 already has a GUI frame (the capture frame doesn't count).
has_frame() {
    local out
    out=$("$EMACSCLIENT" -s "$1" -e '(if (seq-some (lambda (f) (and (display-graphic-p f) (not (equal (frame-parameter f (quote name)) "doom-capture")))) (frame-list)) 1 0)' 2>/dev/null)
    [[ $out == 1 ]]
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

# Open the role's frame on <workspace> unless one is already open.
# The keybinding switches workspace first, so an open frame needs nothing,
# same as launch_terminal.sh. A new frame is moved explicitly because Emacs
# can set its title after aerospace's on-window-detected rules have run.
# Usage: open_frame_on <daemon> <title prefix> <workspace> [emacsclient args...]
open_frame_on() {
    local name=$1 title=$2 ws=$3; shift 3
    take_launch_lock "$name" || return 0
    [[ -n $(window_id "$title") ]] && return 0
    ensure_daemon "$name"
    has_frame "$name" && return 0
    "$EMACSCLIENT" -s "$name" -c -n "$@" >/dev/null 2>&1
    local id
    id=$(wait_for_window "$title") || return 1
    aerospace move-node-to-workspace "$ws" --window-id "$id"
    aerospace focus --window-id "$id"
}
