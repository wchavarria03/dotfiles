#!/usr/bin/env bash

general_packages() {
    echo "${COLOR_GREEN}-- Installing taps${COLOR_RESET}"
    brew tap FelixKratz/formulae ## For borders
    brew tap nikitabobko/tap
    brew trust FelixKratz/formulae 2>/dev/null || true
    brew trust nikitabobko/tap 2>/dev/null || true

    local formulae=(
        asdf
        aspell # word completion
        awscli
        bash
        bash-completion
        borders # requires FelixKratz/formulae tap
        carapace
        direnv
        eza
        fd
        fontconfig
        fzf
        gh
        git
        git-lfs
        gitleaks # secret scanning in .githooks/pre-commit
        glow # markdown previewer
        gnupg
        imagemagick # required for image.nvim inline image rendering
        jq
        lazygit
        luarocks # lua linter and development
        mysql-client # required for dadbod mysql connections
        neovim
        pngpaste # clipboard screenshots
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
    brew_install_formulae \
        herdr # agent multiplexer, standalone (no manager/registration)
    brew_install_casks \
        claude-code
}

personal_packages() {
    echo "${COLOR_GREEN}-- Installing personal packages${COLOR_RESET}"
    brew_install_formulae \
        opencode
    brew_install_casks \
        dbeaver-community \
        discord \
        obsidian \
        tailscale # home lab remote access (nix-homelab)
}

# Packages this setup used to install and no longer needs. Removed if present,
# so re-running the setup also cleans up older machines.
retired_packages() {
    local formulae=(
        pandoc # only used for the one-off org -> Markdown migration of the notes
        cmake # was only required to build Doom's vterm
        coreutils # was only required by Doom Emacs (gls)
        markdown # was only required by Doom's markdown preview
    )
    local casks=(
        emacs-plus-app # Doom Emacs retired, notes + code both moved to Neovim
    )

    for formula in "${formulae[@]}"; do
        if is_brew_formula_installed "$formula"; then
            echo "Removing retired $formula..."
            brew uninstall "$formula"
        fi
    done
    for cask in "${casks[@]}"; do
        if is_brew_cask_installed "$cask"; then
            echo "Removing retired $cask..."
            brew uninstall --cask "$cask"
        fi
    done
}

install_brew_packages() {
    # shellcheck source=helpers.sh
    source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
    ensure_device_type

    run_for_device general_packages work_packages personal_packages

    echo "${COLOR_GREEN}-- Removing retired packages${COLOR_RESET}"
    retired_packages

    echo "${COLOR_GREEN}-- Cleaning up Brew...${COLOR_RESET}"
    brew cleanup
}

install_brew_packages_clean_up() {
    echo "${COLOR_GREEN}Install Brew packages clean up - coming feature...${COLOR_RESET}"
}
