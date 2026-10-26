#!/usr/bin/env bash

# Clones the Doom framework to ~/.config/emacs (gitignored). User config lives in
# ~/.config/doom (tracked, stowed). Runs after brew so git/emacs/fd/rg exist.
setup_doom() {
    local doom_dir="$HOME/.config/emacs"

    if [ -d "$doom_dir" ]; then
        echo "${COLOR_GREEN}-- Doom already cloned, syncing...${COLOR_RESET}"
        "$doom_dir/bin/doom" sync
    else
        git clone --depth 1 https://github.com/doomemacs/core "$doom_dir"
        "$doom_dir/bin/doom" install --force
    fi

    # The Emacs daemons (notes, code) started from aerospace don't inherit the
    # shell's PATH; Doom reads it from this env file instead. Re-run 'doom env'
    # whenever PATH changes (new asdf version, Mason tools...).
    echo "${COLOR_GREEN}-- Snapshotting shell environment for Doom (doom env)...${COLOR_RESET}"
    "$doom_dir/bin/doom" env
}
