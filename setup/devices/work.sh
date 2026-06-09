#!/usr/bin/env bash
# Device contract for work machines.
# Implements: install_device_packages, install_device_fonts, setup_device_config

install_device_packages() {
    echo "${COLOR_GREEN}-- Installing work packages${COLOR_RESET}"
    brew_install_casks \
        claude-code
}

install_device_fonts() {
    : # no work-specific fonts yet
}

setup_device_config() {
    : # no work-specific config yet
}
