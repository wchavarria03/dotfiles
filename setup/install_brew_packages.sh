#!/usr/bin/env bash

install_brew_packages() {
    # shellcheck source=helpers.sh
    source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
    ensure_device_type
    load_device_script

    echo "${COLOR_GREEN}-- Installing taps${COLOR_RESET}"
    brew tap FelixKratz/formulae ## For borders
    brew tap nikitabobko/tap

    local formulae=(
        asdf
        awscli
        bash
        bash-completion
        borders # requires FelixKratz/formulae tap
        carapace
        direnv
        docker-completion
        eza
        fzf
        gemini-cli
        gh
        git-lfs
        glow # markdown previewer
        gnupg
        imagemagick # required for image.nvim inline image rendering
        jq
        lazygit
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
        cursor
        dbeaver-community
        discord
        insomnia
        obsidian
        sequel-ace
        wezterm
    )

    echo "${COLOR_GREEN}-- Installing formulae${COLOR_RESET}"
    brew_install_formulae "${formulae[@]}"

    echo "${COLOR_GREEN}-- Installing casks${COLOR_RESET}"
    brew_install_casks "${casks[@]}"

    install_device_packages

    echo "${COLOR_GREEN}-- Cleaning up Brew...${COLOR_RESET}"
    brew cleanup
}

install_brew_packages_clean_up() {
    echo "${COLOR_GREEN}Install Brew packages clean up - coming feature...${COLOR_RESET}"
}
