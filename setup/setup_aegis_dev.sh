#!/usr/bin/env bash

# Aegis Python dev environment: verifies the tools Aegis's dev workflow
# needs are present and reports anything missing. Installation of uv/ruff
# itself is owned by install_brew_packages.sh — this script only checks,
# and installs the uv-managed tools (mypy, pytest) that aren't brew
# formulae. Never touches unrelated config; safe to re-run.
setup_aegis_dev() {
    local missing=()

    if ! command -v uv >/dev/null 2>&1; then
        missing+=("uv")
    fi

    if ! command -v ruff >/dev/null 2>&1; then
        missing+=("ruff")
    fi

    if ! command -v python >/dev/null 2>&1; then
        missing+=("python (via asdf)")
    fi

    if ! command -v git >/dev/null 2>&1; then
        missing+=("git")
    fi

    if [ ${#missing[@]} -gt 0 ]; then
        echo "${COLOR_GREEN}-- Aegis dev environment incomplete, missing:${COLOR_RESET}"
        for tool in "${missing[@]}"; do
            echo "   - $tool"
        done
        echo "Run install_brew_packages.sh and setup_asdf.sh, then re-run this script."
        return 1
    fi

    echo "${COLOR_GREEN}-- uv, ruff, python, and git all present${COLOR_RESET}"

    echo "${COLOR_GREEN}-- Installing uv-managed dev tools (mypy, pytest)${COLOR_RESET}"
    uv tool install mypy --quiet
    uv tool install pytest --quiet

    echo "${COLOR_GREEN}-- Aegis dev environment ready${COLOR_RESET}"
}

setup_aegis_dev_clean_up() {
    echo "${COLOR_GREEN}Setup aegis dev clean up - coming feature...${COLOR_RESET}"
}
