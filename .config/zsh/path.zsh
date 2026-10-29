# Highest precedence first
paths=(
  $FNM_MULTISHELL_PATH/bin
  $HOME/.yarn/bin
  $HOME/.pyenv/shims
  $HOME/.pyenv/bin
  $HOME/.poetry/bin
  $HOME/.local/bin
  $HOME/.cargo/bin
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
)

export PATH=${(j[:])paths}
