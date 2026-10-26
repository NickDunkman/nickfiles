# Wrap ~/.local/bin/nickfiles so that a successful `nickfiles setup` reloads this shell
# with the freshly installed config. (A child process can't reload its parent shell.)
nickfiles() {
  command nickfiles "$@" || return
  if [[ $1 == setup && -o interactive ]]; then
    # exec skips zsh's history save on exit, so flush this session's history first
    fc -AI
    # a clean reload: `source ~/.zshrc` would keep stale aliases/PATH and double-run zplug/compinit
    exec zsh
  fi
}
