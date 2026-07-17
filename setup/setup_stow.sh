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

    ensure_gitconfig_local_signing
}

# The tracked .gitconfig is OS-portable (no Mac-only paths), so commit
# signing (1Password SSH-sign) lives in a tracked-but-included file instead.
# ~/.gitconfig.local itself stays real and untracked (personal-secrets.zsh
# writes secrets there), so this only ensures it has an [include] pointing
# at the tracked signing config — safe to run multiple times.
ensure_gitconfig_local_signing() {
    local signing_include="~/personal/dotfiles/.config/git/gitconfig.mac.signing"
    local local_config="$HOME/.gitconfig.local"

    touch "$local_config"

    if ! grep -qF "$signing_include" "$local_config"; then
        printf '[include]\n    path = %s\n' "$signing_include" >> "$local_config"
        echo "${COLOR_GREEN}-- Added commit-signing include to ~/.gitconfig.local.${COLOR_RESET}"
    fi
}

setup_stow_clean_up() {
    cd ~/personal/dotfiles || exit
    stow -D . -t ~/
    echo "${COLOR_GREEN}-- Dotfiles symlinks removed.${COLOR_RESET}"
    cd - > /dev/null || exit
}
