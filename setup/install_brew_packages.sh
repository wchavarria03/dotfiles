#!/usr/bin/env bash

is_brew_formula_installed() {
    brew list --formula "$1" &>/dev/null
}

is_brew_cask_installed() {
    brew list --cask "$1" &>/dev/null
}

# Function to install or update Brew packages
install_brew_packages() {
    echo "${COLOR_GREEN}-- Installing tap formulae${COLOR_RESET}"
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
        # claude-code  # work machine only
        cursor
        dbeaver-community
        discord
        insomnia
        obsidian
        sequel-ace
        wezterm
    )

    echo "${COLOR_GREEN}-- Installing formulae${COLOR_RESET}"
    for formula in "${formulae[@]}"; do
        if ! is_brew_formula_installed "$formula"; then
            echo "Installing $formula..."
            brew install "$formula"
        else
            echo "$formula is already installed."
        fi
    done

    echo "${COLOR_GREEN}-- Installing casks${COLOR_RESET}"
    for cask in "${casks[@]}"; do
        if ! is_brew_cask_installed "$cask"; then
            echo "Installing $cask..."
            brew install --cask "$cask"
        else
            echo "$cask is already installed."
        fi
    done

    echo "${COLOR_GREEN}-- Cleaning up Brew...${COLOR_RESET}"
    brew cleanup
}

install_brew_packages_clean_up() {
    echo "${COLOR_GREEN}Install Brew packages clean up - coming feature...${COLOR_RESET}"
}
