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
