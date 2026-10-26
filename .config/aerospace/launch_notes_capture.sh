#!/usr/bin/env zsh
# alt-shift-n: floating org-capture frame from the notes daemon, on the
# workspace you are on. t = TODO, i = idea; both go to ideas_todos.org.
# The frame closes itself after C-c C-c (save) or C-c C-k (cancel).
# Pressing it again while a capture is open brings that one here instead.
source "${0:A:h}/emacs_utils.sh"
take_launch_lock capture || exit 0
ws=$(aerospace list-workspaces --focused)
id=$(window_id "doom-capture")
if [[ -z $id ]]; then
    ensure_daemon notes
    "$EMACSCLIENT" -s notes -n -e '(+org-capture/open-frame)' >/dev/null 2>&1
    id=$(wait_for_window "doom-capture") || exit 1
fi
aerospace move-node-to-workspace "$ws" --window-id "$id"
aerospace focus --window-id "$id"
aerospace layout floating
