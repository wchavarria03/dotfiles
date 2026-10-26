#!/usr/bin/env zsh
# alt-e: coding Emacs (daemon "code") on workspace e.
source "${0:A:h}/emacs_utils.sh"
ensure_daemon code
open_frame_on code "Code Emacs" e
