#!/bin/bash
# Get a brand-new Mac ready to run `nickfiles setup`. Safe to re-run.
#
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/NickDunkman/nickfiles/main/.config/nickfiles/bootstrap.sh)"
#
# Runs under macOS's /bin/bash 3.2, so no bash 4+ features.

set -euo pipefail

NICKFILES_GIT_DIR="$HOME/.nickfiles"
REPO_HTTPS="https://github.com/NickDunkman/nickfiles.git"
REPO_SSH="git@github.com:NickDunkman/nickfiles.git"

say() {
  printf '\n\033[1;34m==>\033[0m \033[1m%s\033[0m\n' "$*"
}

nickfiles_git() {
  git --git-dir="$NICKFILES_GIT_DIR" --work-tree="$HOME" "$@"
}

# 1. Ask for the password once, and keep sudo alive until this script exits
say "Caching sudo credentials (enter your password once)"
sudo -v
while true; do sudo -n true; sleep 50; kill -0 "$$" || exit; done 2>/dev/null &
sudo_keepalive_pid=$!
trap 'kill "$sudo_keepalive_pid" 2>/dev/null || true' EXIT

# 2. Homebrew. Its installer also installs the Xcode Command Line Tools, which provide git.
if [ ! -x /opt/homebrew/bin/brew ]; then
  say "Installing Homebrew and the Xcode Command Line Tools"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  say "Skip Homebrew's \"Next steps\" above -- nickfiles' zsh config already puts Homebrew on your PATH"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. What `nickfiles setup` needs before the full Brewfile has been installed
say "Installing just and uv"
brew install just uv

# 4. Clone the bare repo
if [ ! -d "$NICKFILES_GIT_DIR" ]; then
  say "Cloning nickfiles into $NICKFILES_GIT_DIR"
  git clone --bare "$REPO_HTTPS" "$NICKFILES_GIT_DIR"
fi
nickfiles_git config status.showUntrackedFiles no
nickfiles_git config core.hooksPath "$HOME/.config/nickfiles/hooks"
nickfiles_git config remote.origin.pushurl "$REPO_SSH"
# bare clones don't set up remote-tracking branches
nickfiles_git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
nickfiles_git fetch --quiet origin
nickfiles_git branch --quiet --set-upstream-to=origin/main main

# 5. Check the files out into $HOME (only the first time -- after that, `nickfiles setup` pulls)
if [ -z "$(nickfiles_git ls-files)" ]; then
  say "Checking out nickfiles into $HOME"
  if ! nickfiles_git checkout 2>/dev/null; then
    backup_dir="$HOME/.nickfiles-backup/$(date +%Y%m%d-%H%M%S)"
    say "Moving existing files that nickfiles would overwrite into $backup_dir"
    nickfiles_git ls-tree -r -z --name-only HEAD | while IFS= read -r -d '' path; do
      if [ -e "$HOME/$path" ] || [ -L "$HOME/$path" ]; then
        mkdir -p "$backup_dir/$(dirname "$path")"
        mv "$HOME/$path" "$backup_dir/$path"
        echo "    $path"
      fi
    done
    nickfiles_git checkout
  fi
fi

say "Bootstrap complete! Open a new terminal tab and run:  nickfiles setup"
