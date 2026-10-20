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
    ensure_gitconfig_local_github_auth
    ensure_github_envrc
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

# Per-directory GitHub PAT helpers are macOS-only (they need direnv + 1Password),
# so the includeIf blocks live in ~/.gitconfig.local, not the portable .gitconfig.
# Windows keeps Git Credential Manager. Safe to run multiple times.
ensure_gitconfig_local_github_auth() {
    local local_config="$HOME/.gitconfig.local"
    local dir name

    touch "$local_config"

    for dir in personal work; do
        name="gitdir:~/$dir/"
        if ! grep -qF "[includeIf \"$name\"]" "$local_config"; then
            printf '[includeIf "%s"]\n    path = ~/personal/dotfiles/.config/git/gitconfig.%s\n' "$name" "$dir" >> "$local_config"
            echo "${COLOR_GREEN}-- Added $dir GitHub credential include to ~/.gitconfig.local.${COLOR_RESET}"
        fi
    done
}

# .envrc files hold only 1Password references (no secrets), so they are safe to
# create. Existing files are never overwritten. Requires `op` signed in to both accounts.
ensure_github_envrc() {
    write_envrc "$HOME/personal/.envrc" "my.1password.com" "op://Private/GitHub PAT - Personal/token" "Personal"
    write_envrc "$HOME/work/.envrc" "ltvco.1password.com" "op://Employee/Github PAT - LTV/token" "Work"

    if command -v direnv > /dev/null; then
        direnv allow "$HOME/personal" "$HOME/work" 2> /dev/null || true
    fi
}

write_envrc() {
    local file="$1" account="$2" ref="$3" label="$4"

    [ -e "$file" ] && return 0
    [ -d "$(dirname "$file")" ] || return 0

    printf '# %s GitHub PAT, read from 1Password. Never commit.\nexport GITHUB_PAT=$(op read --account %s "%s")\n' "$label" "$account" "$ref" > "$file"
    echo "${COLOR_GREEN}-- Created $file.${COLOR_RESET}"
}

setup_stow_clean_up() {
    cd ~/personal/dotfiles || exit
    stow -D . -t ~/
    echo "${COLOR_GREEN}-- Dotfiles symlinks removed.${COLOR_RESET}"
    cd - > /dev/null || exit
}
