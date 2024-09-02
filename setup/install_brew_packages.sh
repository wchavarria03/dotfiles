#!/usr/bin/env bash

# Function to install or update Brew packages
install_brew_packages() {
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
        # alacritty
        kitty
        brave-browser
        docker
        gnupg
        iterm2
        notion
        bruno
        insomnia
        sequel-ace
        slack
        1password
        1password/tap/1password-cli
        raycast

        # Terminal suggestions
        bash-completion
        zsh-syntax-highlighting
        zsh-autosuggestions
        docker-completion

    )

    echo "${COLOR_GREEN}Brew packages...${COLOR_RESET}"
    for package in "${packages[@]}"; do
        if brew info "$package" &>/dev/null; then
            echo "${COLOR_GREEN}- $package already installed.${COLOR_RESET}"
        else
            echo "${COLOR_GREEN}- Installing $package...${COLOR_RESET}"
            brew install "$package"
        fi
    done

    echo "${COLOR_GREEN}- Cleaning up Brew...${COLOR_REST}"
    brew cleanup
}

install_brew_packages_clean_up() {
    echo "${COLOR_GREEN}Install Brew packages clean up - coming feature...${COLOR_RESET}"
}
