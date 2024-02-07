# ALIASES ---------------------------------------------------------------------
alias d=docker
alias dc=docker-compose
alias dkill="pgrep \"Docker\" | xargs kill -9"
alias hcat='highlight -O ansi'

alias v='nvim -w ~/.vimlog "$@"'
alias vi='nvim -w ~/.vimlog "$@"'
alias vim='nvim -w ~/.vimlog "$@"'

alias zn='vim $NOTES_DIR/$(date +"%Y%m%d%H%M.md")'

# Define a function for the alias
lst() {
  local level=${1:-2}  # Use the provided level or default to 2 if not provided
  exa -aT --icons -I 'node_modules|gems|images|.git|media' --level $level
}

alias l='exa -lah'
alias ls='exa -lag --header --classify --no-user --no-permissions --icons'
alias lst="lst"
alias sl=exa
alias c='clear'
alias trim="awk '{\$1=\$1;print}'"
alias ..='cd ..'
alias ...='cd ../..'
alias mkdir='mkdir -p'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias h='history'

# GIT ALIASES -----------------------------------------------------------------
alias gc='git commit'
alias gco='git checkout'
alias ga='git add'
alias gaa='git add .'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch -D'
alias gcp='git cherry-pick'
alias gd='git diff -w'
alias gds='git diff -w --staged'
alias grs='git restore --staged'
alias gst='git rev-parse --git-dir > /dev/null 2>&1 && git status || exa'
alias gu='git reset --soft HEAD~1'
alias gpr='git remote prune origin'
alias ff='gpr && git pull --ff-only'
alias grd='git fetch origin && git rebase origin/deploy'
alias gbb='git-switchbranch'
alias gbf='git branch | head -1 | xargs' # top branch
alias gl=pretty_git_log
alias gla=pretty_git_log_all
#alias gl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(green)%an %ar %C(reset) %C(bold magenta)%d%C(reset)'"
#alias gla="git log --all --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(bold magenta)%d%C(reset)'"
alias git-current-branch="git branch | grep \* | cut -d ' ' -f2"
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gec='git status | grep "both modified:" | cut -d ":" -f 2 | trim | xargs nvim -'
alias gcan='gc --amend --no-edit'

alias gp="git push -u 2>&1 | tee >(cat) | grep \"pull/new\" | awk '{print \$2}' | xargs open"
alias gpf='git push --force-with-lease'

alias gbdd='git-branch-utils -d'
alias gbuu='git-branch-utils -u'
alias gbrr='git-branch-utils -r -b develop'
alias gg='git branch | fzf | xargs git checkout'
alias gup='git branch --set-upstream-to=origin/$(git-current-branch) $(git-current-branch)'

alias gnext='git log --ancestry-path --format=%H ${commit}..master | tail -1 | xargs git checkout'
alias gprev='git checkout HEAD^'

function take {
    mkdir -p $1
    cd $1
}

mff ()
{
    local curr_branch=`git-current-branch`
    gco master
    ff
    gco $curr_branch
}

dclear () {
    docker ps -a -q | xargs docker kill -f
    docker ps -a -q | xargs docker rm -f
    docker images | grep "api\|none" | awk '{print $3}' | xargs docker rmi -f
    docker volume prune -f
}

alias docker-clear=dclear

dreset () {
    dclear
    docker images -q | xargs docker rmi -f
    docker volume rm $(docker volume ls |awk '{print $2}')
    rm -rf ~/Library/Containers/com.docker.docker/Data/*
    docker system prune -a
}

JOBFILE="$DOTFILES/job-aliases.zsh"
if [ -f "$JOBFILE" ]; then
    source "$JOBFILE"
fi
