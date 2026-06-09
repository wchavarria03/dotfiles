#!/usr/bin/env bash

setup_asdf() {
    # Source asdf so it's available in this shell session
    if [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
        # shellcheck disable=SC1090
        source "$(brew --prefix asdf)/libexec/asdf.sh"
    else
        echo "asdf not found — make sure brew packages are installed first."
        return 1
    fi

    local plugins=(nodejs python golang rust)

    echo "${COLOR_GREEN}-- Adding asdf plugins${COLOR_RESET}"
    for plugin in "${plugins[@]}"; do
        if asdf plugin list | grep -q "^${plugin}$"; then
            echo "${COLOR_GREEN}-- asdf plugin $plugin already added.${COLOR_RESET}"
        else
            echo "${COLOR_GREEN}-- Adding asdf plugin: $plugin${COLOR_RESET}"
            asdf plugin add "$plugin"
        fi
    done

    echo "${COLOR_GREEN}-- Installing tool versions from .tool-versions${COLOR_RESET}"
    cd ~/personal/dotfiles || exit
    asdf install
    cd - > /dev/null || exit
}

setup_asdf_clean_up() {
    echo "${COLOR_GREEN}Setup asdf clean up - coming feature...${COLOR_RESET}"
}
