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

# Sources the device-specific script (devices/work.sh or devices/personal.sh).
# Must be called after ensure_device_type.
# Device scripts must implement: install_device_packages(), setup_device_config()
load_device_script() {
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local device_script="${script_dir}/devices/${DEVICE_TYPE}.sh"

    if [ ! -f "$device_script" ]; then
        echo "ERROR: No device script found for '${DEVICE_TYPE}' at ${device_script}"
        exit 1
    fi

    # shellcheck disable=SC1090
    source "$device_script"
}

# ── Brew helpers ────────────────────────────────────────────────────────────

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
