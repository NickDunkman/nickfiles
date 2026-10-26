export NICKFILES_DIR="$HOME/.config/nickfiles"

export FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# grab all .zsh files
setopt EXTENDED_GLOB
typeset -U config_files
config_files=($HOME/.config/zsh/**/*.zsh(N))

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# load everything but the path, completion, and aliases files
for file in ${${${config_files:#*/path.zsh}:#*/completion.zsh}:#*/aliases/*.zsh}
do
  source $file
done

# powerlevel10k prompt config
[ -f $HOME/.p10k.zsh ] && source $HOME/.p10k.zsh

# initalize autocomplete and then load every completion.zsh
autoload -U compinit
compinit
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

# load custom aliases at the end so they override anything set by plugins, for example
for file in ${(M)config_files:#*/aliases/*.zsh}
do
  source $file
done

unset config_files
