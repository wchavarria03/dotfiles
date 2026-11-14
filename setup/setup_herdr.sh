#!/usr/bin/env bash

# Herdr agent-state integrations. These write hook/plugin files outside the
# repo (e.g. ~/.claude/hooks/herdr-agent-state.sh), so every machine has to
# run this after stow instead of relying on the tracked settings alone.
setup_herdr() {
    if ! command -v herdr >/dev/null 2>&1; then
        echo "${COLOR_GREEN}-- herdr not installed, skipping integrations${COLOR_RESET}"
        return 0
    fi

    local agents=(claude opencode)

    for agent in "${agents[@]}"; do
        echo "${COLOR_GREEN}-- Installing herdr integration: ${agent}${COLOR_RESET}"
        herdr integration install "$agent"
    done

    herdr integration status --outdated-only
}
