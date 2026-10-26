# nickfiles

My dotfiles. This repo is cloned bare into `~/.nickfiles`, with `$HOME` as its work tree. Every file here lives at its real path in my home directory, with no symlinks.

## New Mac

In Terminal, run this and enter your password once:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/NickDunkman/nickfiles/main/.config/nickfiles/bootstrap.sh)"
```

Then open a new terminal tab and run:

```sh
nickfiles setup
```

## Day to day

`nickfiles` is one command for everything:

- `nickfiles setup` installs and updates everything: it pulls the latest nickfiles, then runs every setup step. Re-run it any time.
- `nickfiles <recipe>` runs any other recipe from [`~/.config/nickfiles/justfile`](../.config/nickfiles/justfile).
- `nickfiles <git command>` runs git against the bare repo, e.g. `nickfiles status`, `nickfiles add ~/.zshrc`, `nickfiles commit`.
- `nickfiles` on its own lists the recipes and shows `git status`.
