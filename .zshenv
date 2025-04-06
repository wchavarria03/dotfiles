#!/usr/bin/env zsh

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################
export WORKSPACE_PERSONAL="$HOME/personal"
export WORKSPACE_WORK="$HOME/work"
export SECRETSREPO="$HOME/personal/secrets"
export DOTFILES="$HOME/personal/dotfiles"
export NOTES_DIR="$HOME/personal/notes"

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
export HISTSIZE=1000                                    # Maximum events for internal history
export SAVEHIST=999                                     # Maximum events in history file
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# OTHER
export VIMCONFIG="$XDG_CONFIG_HOME/nvim"
. "$HOME/.cargo/env"
