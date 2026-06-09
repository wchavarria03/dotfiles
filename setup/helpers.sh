#!/usr/bin/env bash

# Prompts for device type if DEVICE_TYPE is not already set.
# Safe to call multiple times — only prompts once per session.
ensure_device_type() {
    if [ -n "$DEVICE_TYPE" ]; then
        return 0
    fi

    echo ""
    echo "Which device type?"
    echo "  1) personal"
    echo "  2) work"
    read -rp "> " choice
    case "$choice" in
        1) export DEVICE_TYPE="personal" ;;
        2) export DEVICE_TYPE="work" ;;
        *) echo "Invalid choice — expected 1 or 2."; exit 1 ;;
    esac
    echo "${COLOR_GREEN}-- Device type set to: ${DEVICE_TYPE}${COLOR_RESET}"
    echo ""
}

# Calls $1 (general) always, then $2 (work) or $3 (personal) based on DEVICE_TYPE.
# Usage: run_for_device general_fn work_fn personal_fn
run_for_device() {
    "$1"
    if [ "$DEVICE_TYPE" = "work" ]; then
        "$2"
    else
        "$3"
    fi
}

# ── Brew helpers ─────────────────────────────────────────────────────────────

is_brew_formula_installed() {
    brew list --formula "$1" &>/dev/null
}

is_brew_cask_installed() {
    brew list --cask "$1" &>/dev/null
}

brew_install_formulae() {
    for formula in "$@"; do
        if ! is_brew_formula_installed "$formula"; then
            echo "Installing $formula..."
            brew install "$formula"
        else
            echo "$formula is already installed."
        fi
    done
}

brew_install_casks() {
    for cask in "$@"; do
        if ! is_brew_cask_installed "$cask"; then
            echo "Installing $cask..."
            brew install --cask "$cask"
        else
            echo "$cask is already installed."
        fi
    done
}
