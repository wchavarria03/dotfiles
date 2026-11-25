#Check the architecture and set the Homebrew path accordingly
if [[ "$(uname -m)" == "arm64" ]]; then
    # Apple Silicon
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # Intel
    eval "$(/usr/local/bin/brew shellenv)"
fi

### PATH: the single place PATH is set (typeset -U drops duplicates) ###
# Order is highest priority first. cargo/carapace only prepend themselves when
# missing, so their order drifts in nested shells; pinning them here fixes it.
export GOBIN="$HOME/go/bin"
typeset -U path
path=(
    "$HOME/.cargo/bin"
    "$XDG_CONFIG_HOME/carapace/bin"
    /opt/homebrew/opt/mysql-client/bin
    "$XDG_DATA_HOME/nvim/mason/bin"
    /opt/homebrew/opt/rustup/bin
    "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
    "$HOME/bin"
    $path
    "$ANDROID_HOME/platform-tools"
    "$GOBIN"
    "$HOME/.local/bin"
)

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

eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"

source <(fzf --zsh)

# Use zsh history on arrow up/down
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# jump word to work on zsh input
bindkey '˙' backward-word # ⌥ + h  [skip word backward]
bindkey '¬' forward-word  # ⌥ + j [skip word forward]

### ASDF completions ###
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

### Initialize brew completions ###
autoload -Uz compinit
compinit

### Carapace ###
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
compdef v=nvim # bridge 'v' alias to nvim completions so carapace doesn't error

### rust language ###
. "$HOME/.cargo/env"

### DirEnv ###
eval "$(direnv hook zsh)"

# device-local overrides, not tracked (see ~/.gitconfig.local for git)
[ -f "$HOME/.zshrc.local" ] && . "$HOME/.zshrc.local"
