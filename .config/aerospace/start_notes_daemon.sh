#!/usr/bin/env zsh
# Run by aerospace after-startup-command: start the notes Emacs daemon at login,
# so the first alt-p / alt-shift-n opens instantly. No frame is opened.
source "${0:A:h}/emacs_utils.sh"
ensure_daemon notes
