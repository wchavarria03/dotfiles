#!/usr/bin/env bash

# Function to check if a Brew package is instal
led
is_brew_package_installed() {
    local package_name="$1"
    brew list "$package_name" &>/dev/null
    return $?
}

# Function to install or update Brew packages
install_brew_packages() {
    echo "${COLOR_GREEN}-- Installing tap formulae${COLOR_RESET}"
    brew tap FelixKratz/formulae ## For borders

    local packages=(
        asdf
        bash
        direnv
        eza
        fzf
        git
        glow # markdown previewer
        luarocks #lua linter and development
        neovim
        ripgrep
        rustup # install rust top to get cargo and be able to install some mason lsp with mason
        starship
        zoxide
        zsh

        # APPS
        1password
        1password-cli
        brave-browser
        dbeaver-community
        discord
        docker
        ghostty
        gnupg
        insomnia
        kitty
        raycast
        sequel-ace
        slack

        # CLI apps
        gh
        lazygit

        ## Desktop Manager
        aerospace
        borders # requires formulae tap

        # Terminal suggestions
        bash-completion
        docker-completion
        zsh-autosuggestions
        zsh-syntax-highlighting
    )

    for package in "${packages[@]}"; do
        if ! is_brew_package_installed "$package"; then
            echo "Installing $package..."
            brew install "$package"
        else
            echo "$package is already installed."
        fi
    done

    echo "${COLOR_GREEN}-- Cleaning up Brew...${COLOR_REST}"
    brew cleanup
}
install_brew_packages_clean_up() {
    echo "${COLOR_GREEN}Install Brew packages clean up - coming feature...${COLOR_RESET}"
}
