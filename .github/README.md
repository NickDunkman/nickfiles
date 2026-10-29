# nickfiles

My dotfiles. This repo is cloned bare into `~/.nickfiles.git`, with `$HOME` as its work tree. Every file here lives at its real path in my home directory, with no symlinks.

## New Mac

In Terminal, run this and enter your password once:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/NickDunkman/nickfiles/main/.config/nickfiles/bootstrap.sh)"
```

Then open a new terminal tab and run:

```sh
nickfiles upstall
```

## Day to day

`nickfiles` runs recipes from [`~/.config/nickfiles/justfile`](../.config/nickfiles/justfile):

- `nickfiles upstall` installs and updates everything: it pulls the latest nickfiles, then runs every install step. Re-run it any time.
- `nickfiles git <args>` runs git against the bare repo, e.g. `nickfiles git status`, `nickfiles git add ~/.zshrc`, `nickfiles git commit`.
- `nickfiles` on its own lists the recipes and shows `git status`.

Tab completion works for recipe names, and for everything after `nickfiles git` (subcommands, branches, and files from this repo).
