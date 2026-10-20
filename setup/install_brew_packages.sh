#!/usr/bin/env bash

general_packages() {
    echo "${COLOR_GREEN}-- Installing taps${COLOR_RESET}"
    brew tap FelixKratz/formulae ## For borders
    brew tap nikitabobko/tap
    brew trust FelixKratz/formulae 2>/dev/null || true
    brew trust nikitabobko/tap 2>/dev/null || true

    local formulae=(
        asdf
        awscli
        bash
        bash-completion
        borders # requires FelixKratz/formulae tap
        carapace
        coreutils # required by Doom Emacs (gls)
        direnv
        emacs
        eza
        fd # required by Doom Emacs
        fontconfig # lets doom doctor detect fonts
        fzf
        gh
        git # required by Doom Emacs
        git-lfs
        gitleaks # secret scanning in .githooks/pre-commit
        glow # markdown previewer
        gnupg
        imagemagick # required for image.nvim inline image rendering
        jq
        lazygit
        markdown # compiler for Doom :lang markdown preview
        luarocks # lua linter and development
        mysql-client # required for dadbod mysql connections
        neovim
        podman
        ripgrep
        rustup # required for cargo and some mason lsp installs
        starship
        stow
        tree-sitter-cli
        zoxide
        zsh
        zsh-autosuggestions
        zsh-syntax-highlighting
    )

    local casks=(
        1password-cli
        aerospace # requires nikitabobko/tap
        brave-browser
        obsidian
        sequel-ace
        wezterm
    )

    echo "${COLOR_GREEN}-- Installing formulae${COLOR_RESET}"
    brew_install_formulae "${formulae[@]}"

    echo "${COLOR_GREEN}-- Installing casks${COLOR_RESET}"
    brew_install_casks "${casks[@]}"
}

work_packages() {
    echo "${COLOR_GREEN}-- Installing work packages${COLOR_RESET}"
    brew_install_casks \
        claude-code
}

personal_packages() {
    echo "${COLOR_GREEN}-- Installing personal packages${COLOR_RESET}"
    brew_install_formulae \
        opencode
    brew_install_casks \
        dbeaver-community \
        discord
}

install_brew_packages() {
    # shellcheck source=helpers.sh
    source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
    ensure_device_type

    run_for_device general_packages work_packages personal_packages

    echo "${COLOR_GREEN}-- Cleaning up Brew...${COLOR_RESET}"
    brew cleanup
}

install_brew_packages_clean_up() {
    echo "${COLOR_GREEN}Install Brew packages clean up - coming feature...${COLOR_RESET}"
}
