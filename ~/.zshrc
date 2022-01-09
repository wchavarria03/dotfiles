
# zsh-completion
if type brew &>/dev/null; then
  FPATH=/usr/local/share/zsh-completions:/Users/wchavarria/.oh-my-zsh/plugins/git:/Users/wchavarria/.oh-my-zsh/functions:/Users/wchavarria/.oh-my-zsh/completions:/Users/wchavarria/.oh-my-zsh/cache/completions:/usr/local/share/zsh/site-functions:/usr/share/zsh/site-functions:/usr/share/zsh/5.8/functions

  autoload -Uz compinit
  compinit
fi
