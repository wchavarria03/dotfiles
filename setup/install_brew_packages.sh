#!/usr/bin/env bash

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
        python3
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
        1password/tap/1password-cli
        obsidian
        raycast
        wezterm

        aeroSpace
        borders # requires formulae tap

        # Terminal suggestions
        bash-completion
        zsh-syntax-highlighting
        zsh-autosuggestions
        docker-completion
    )

    for package in "${packages[@]}"; do
        if brew info "$package" &>/dev/null; then
            echo "${COLOR_GREEN}-- $package already installed.${COLOR_RESET}"
        else
            echo "${COLOR_GREEN}-- Installing $package...${COLOR_RESET}"
            brew install "$package"
        fi
    done

    echo "${COLOR_GREEN}-- Cleaning up Brew...${COLOR_REST}"
    brew cleanup
}

install_brew_packages_clean_up() {
    echo "${COLOR_GREEN}Install Brew packages clean up - coming feature...${COLOR_RESET}"
}
