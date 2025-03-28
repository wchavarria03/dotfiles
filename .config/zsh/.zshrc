# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.docker/bin:$HOME/bin:/usr/local/bin:$PATH

COMPLETION_WAITING_DOTS="true"

# Source plugins manually
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided
source $DOTFILES/.config/zsh/aliases.zsh

# Bash completion
[[ -r \"/usr/local/etc/profile.d/bash_completion.sh\" ]] && . \"/usr/local/etc/profile.d/bash_completion.sh

export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(op signin)"

source <(fzf --zsh)

# Use zsh history on arrow up/down
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# jump word to work on zsh input
bindkey '˙' backward-word  # ⌥ + ← [skip word backward]
bindkey '¬' forward-word   # ⌥ + → [skip word forward]

############
### ASDF ###
############
# Add ASDF shims to PATH
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Configure ASDF completions
fpath=("${ASDF_DATA_DIR:-$HOME/.asdf}/completions" $fpath)
autoload -Uz compinit && compinit

# Load ASDF Golang plugin environment
source "$ASDF_CONFIG_FILE/plugins/golang/set-env.zsh"

