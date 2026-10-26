#!/usr/bin/env zsh
# alt-p: notes Emacs (daemon "notes") on workspace p; opens Home the first time.
source "${0:A:h}/emacs_utils.sh"
ensure_daemon notes
open_frame_on notes "Notes Emacs" p \
    --eval '(find-file (expand-file-name "home.org" org-directory))'
