#!/usr/bin/env zsh

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################
export WORKSPACE="$HOME/code"
export SECRETSREPO="$HOME/code/secrets"
export DOTFILES="$HOME/code/dotfiles"
export NOTES_DIR="~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents"

[ -f "$DOTFILES/install_config" ] && source "$DOTFILES/install_config"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# EDITOR
export EDITOR="nvim"
export VISUAL="nvim"

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"                    # History filepath
export HISTSIZE=5000                                    # Maximum events for internal history
export SAVEHIST=5000                                    # Maximum events in history file

# OTHER
export VIMCONFIG="$XDG_CONFIG_HOME/nvim"
export ASDF_DATA_DIR="$HOME/.config/asdf"
export ASDF_CONFIG_FILE="$HOME/.config/asdf"
