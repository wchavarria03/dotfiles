# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.docker/bin:$HOME/bin:/usr/local/bin:$PATH

COMPLETION_WAITING_DOTS="true"

# Source plugins manually
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided
source $DOTFILES/.config/zsh/aliases.zsh

# Bash completion
[[ -r \"/usr/local/etc/profile.d/bash_completion.sh\" ]] && . \"/usr/local/etc/profile.d/bash_completion.sh

export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export GOPATH=$(asdf where golang)/packages
export GOBIN=$(asdf where golang)/packages/bin
export GOROOT=$(asdf where golang)/go
export GOPRIVATE="github.com/ltvco/*"
export PATH="$GOBIN:$GOROOT/bin:${PATH}"

eval "$(starship init zsh)"

eval "$(zoxide init --cmd cd zsh)"

bindkey '˙' backward-word  # ⌥ + ← [skip word backward]
bindkey '¬' forward-word   # ⌥ + → [skip word forward]

source <(fzf --zsh)

# source /Users/wchavarria/.config/op/plugins.sh

. $(brew --prefix asdf)/libexec/asdf.sh
