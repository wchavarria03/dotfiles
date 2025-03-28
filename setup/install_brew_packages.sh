#!/usr/bin/env bash

# Function to check if a Brew package is installed
is_brew_package_installed() {
    local package_name="$1"
    brew list "$package_name" &>/dev/null
    return $?
}

# Function to install or update Brew packages
install_brew_packages() {
    # Borders in conjuntion with AeroSpace
    echo "${COLOR_GREEN}-- Installing tap formulae${COLOR_RESET}"
    brew tap FelixKratz/formulae


    local packages=(
        asdf
        bash
        direnv
        eza
        fzf
        git
        gh
        glow # markdown previewer
        neovim
        npm
        ripgrep
        starship
        nvim
        zoxide
        zsh

        # APPS
        brave-browser
        dbeaver-community
        docker
        gnupg
        insomnia
        sequel-ace
        slack
        1password
        1password-cli
        obsidian
        raycast
        kitty
        ghostty

        # CLI apps
        atac
        dblab

        ## Desktop Manager
        aeroSpace
        borders # requires formulae tap

        # Terminal suggestions
        bash-completion
        zsh-syntax-highlighting
        zsh-autosuggestions
        docker-completion
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
