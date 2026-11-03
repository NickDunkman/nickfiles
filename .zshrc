export NICKFILES_DIR="$HOME/.config/nickfiles"

# where compinit finds completion functions: my own (e.g. _nickfiles), then Homebrew's (just, git, gh, ...)
typeset -U fpath
fpath=($HOME/.config/zsh/functions /opt/homebrew/share/zsh/site-functions $fpath)

export FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

zsh_config_dir=$HOME/.config/zsh

# PATH first, so everything after can find their tools
source $zsh_config_dir/path.zsh

source $zsh_config_dir/direnv.zsh
source $zsh_config_dir/grc.zsh
source $zsh_config_dir/nickfiles.zsh
source $zsh_config_dir/p10k.zsh
source $zsh_config_dir/plugins.zsh
source $zsh_config_dir/python.zsh
source $zsh_config_dir/vim.zsh

# this is included last so that my custom aliases always override
source $zsh_config_dir/aliases.zsh

# initialize autocomplete. zplug already runs compinit when it loads plugins, so this
# only runs if the plugins aren't installed yet.
if (( ! $+functions[compdef] )); then
  autoload -U compinit
  compinit
fi

unset zsh_config_dir
