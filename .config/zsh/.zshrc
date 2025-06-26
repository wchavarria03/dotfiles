# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.docker/bin:$HOME/bin:/usr/local/bin:$PATH
FPATH="$HOME/.docker/completions:$FPATH"

#Check the architecture and set the Homebrew path accordingly
if [[ "$(uname -m)" == "arm64" ]]; then
    # Apple Silicon
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # Intel
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Source plugins manually
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided
source $DOTFILES/.config/zsh/aliases.zsh

# Bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

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
bindkey '˙' backward-word # ⌥ + h  [skip word backward]
bindkey '¬' forward-word  # ⌥ + j [skip word forward]

############
### ASDF ###
############
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
. ~/.asdf/plugins/golang/set-env.zsh
export PATH="$PATH:$(go env GOBIN)"

# Initialize brew completions
autoload -Uz compinit
compinit

export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
