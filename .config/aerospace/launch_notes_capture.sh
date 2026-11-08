#!/usr/bin/env zsh
# alt-shift-n: floating quick-capture window, appends to ideas_todos.md.
# nvim opens at the end of the file in insert mode; :wq saves and the window
# closes itself (the wezterm process exits). Pressing it again while a
# capture window is already open just brings that one here instead.
TITLE="Notes Capture"
SCRIPT_DIR=/Users/wchavarria/personal/dotfiles/.config/aerospace
WEZTERM=/Applications/WezTerm.app/Contents/MacOS/wezterm

window_id() {
    aerospace list-windows --all --format '%{window-id}|%{window-title}' 2>/dev/null \
        | grep -F "|$1" | head -1 | cut -d'|' -f1
}

id=$(window_id "$TITLE")
if [[ -z $id ]]; then
    nohup "$WEZTERM" start --always-new-process "$SCRIPT_DIR/notes_capture_terminal.sh" > /dev/null 2>&1 & disown 2>/dev/null
    for _ in {1..30}; do
        id=$(window_id "$TITLE")
        [[ -n $id ]] && break
        sleep 0.1
    done
    [[ -z $id ]] && exit 1
fi

ws=$(aerospace list-workspaces --focused)
aerospace move-node-to-workspace "$ws" --window-id "$id"
aerospace focus --window-id "$id"
aerospace layout floating
