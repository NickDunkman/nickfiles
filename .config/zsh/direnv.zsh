# load .envrc files automatically (direnv itself comes from the Brewfile)
if command -v direnv &>/dev/null
then
  eval "$(direnv hook zsh)"
fi
