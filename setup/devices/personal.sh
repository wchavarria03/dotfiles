#!/usr/bin/env bash
# Device contract for personal machines.
# Implements: install_device_packages, install_device_fonts, setup_device_config

install_device_packages() {
    echo "${COLOR_GREEN}-- Installing personal packages${COLOR_RESET}"
    brew_install_formulae \
        opencode
}

install_device_fonts() {
    : # no personal-specific fonts yet
}

setup_device_config() {
    : # no personal-specific config yet
}
