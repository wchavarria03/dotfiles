#!/usr/bin/env bash

general_asdf() {
    # Source asdf so it's available in this shell session
    if [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
        # shellcheck disable=SC1090
        source "$(brew --prefix asdf)/libexec/asdf.sh"
    else
        echo "asdf not found — make sure brew packages are installed first."
        return 1
    fi

    local plugins=(nodejs python rust) # golang managed by brew to align with golangci-lint

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

work_asdf() {
    : # no work-specific asdf plugins yet
}

personal_asdf() {
    : # no personal-specific asdf plugins yet
}

setup_asdf() {
    # shellcheck source=helpers.sh
    source "$(dirname "${BASH_SOURCE[0]}")/helpers.sh"
    ensure_device_type

    run_for_device general_asdf work_asdf personal_asdf
}

setup_asdf_clean_up() {
    echo "${COLOR_GREEN}Setup asdf clean up - coming feature...${COLOR_RESET}"
}
