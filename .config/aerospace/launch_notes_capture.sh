#!/usr/bin/env zsh
# alt-shift-n: floating org-capture frame from the notes daemon, on the
# workspace you are on. t = TODO, i = idea; both go to ideas_todos.org.
# The frame closes itself after C-c C-c (save) or C-c C-k (cancel).
source "${0:A:h}/emacs_utils.sh"
ws=$(aerospace list-workspaces --focused)
ensure_daemon notes
"$EMACSCLIENT" -s notes -n -e '(+org-capture/open-frame)' >/dev/null 2>&1
id=$(wait_for_window "doom-capture") || exit 1
aerospace move-node-to-workspace "$ws" --window-id "$id"
aerospace focus --window-id "$id"
aerospace layout floating
