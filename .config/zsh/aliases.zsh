# Loaded last by ~/.zshrc, so these override aliases set by plugins

# git (most of these run scripts in ~/.local/bin)
alias gc="git-cleanup"
alias gf="git-fresh"
alias gp="git-pretty-print"
alias gr="git-rebase-origin-head-branch"
alias gsu="git submodule update --init --recursive"
alias s="stree"

# ls via GNU ls (gls, from Homebrew's coreutils)
if command -v gls &>/dev/null; then
  alias l="gls -lAhF --group-directories-first --color"
  alias ll="gls -lAhF --group-directories-first --color"
  alias ls="gls -F --color"
fi

# VS Code
alias v="code ."

# docker: stop & remove all containers, then remove dangling images
alias wtf='docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi $(docker images -f dangling=true -q)'
# docker, harder: also prune networks & dangling volumes, and remove ALL images
alias WTF='docker stop $(docker ps -a -q); docker network prune -f; ! docker rm $(docker ps -a -q); docker volume rm $(docker volume ls -f dangling=true -q); docker rmi $(docker images -f dangling=true -q); docker rmi $(docker images -a -q) -f'
