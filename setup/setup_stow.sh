#!/usr/bin/env bash

setup_stow() {
    if [ ! -d ~/personal/dotfiles ]; then
        echo "Dotfiles repo not found at ~/personal/dotfiles — skipping stow."
        return 1
    fi

    cd ~/personal/dotfiles || exit
    stow . -t ~/
    echo "${COLOR_GREEN}-- Dotfiles symlinked via stow.${COLOR_RESET}"
    cd - > /dev/null || exit
}

setup_stow_clean_up() {
    cd ~/personal/dotfiles || exit
    stow -D . -t ~/
    echo "${COLOR_GREEN}-- Dotfiles symlinks removed.${COLOR_RESET}"
    cd - > /dev/null || exit
}
