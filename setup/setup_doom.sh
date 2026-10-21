#!/usr/bin/env bash

# Clones the Doom framework to ~/.config/doom-emacs (gitignored). User config lives in
# ~/.config/doom (tracked, stowed). Runs after brew so git/emacs/fd/rg exist.
setup_doom() {
    local doom_dir="$HOME/.config/doom-emacs"

    if [ -d "$doom_dir" ]; then
        echo "${COLOR_GREEN}-- Doom already cloned. Run 'doom sync' after config changes.${COLOR_RESET}"
        return 0
    fi

    git clone --depth 1 https://github.com/doomemacs/core "$doom_dir"
    "$doom_dir/bin/doom" install --force
}
