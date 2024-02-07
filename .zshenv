#!/usr/bin/env zsh

echo "zshenv is being sourced!"

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################

export TERM='rxvt-256color'
export DOTFILES="$HOME/code/dotfiles"
export WORKSPACE="$HOME/code"

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
