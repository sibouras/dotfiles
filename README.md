# My dotfiles

## Installation

```bash
git clone https://github.com/sibouras/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

then use GNU stow to create symlinks

before stowing make sure the directory exists and doesn't have a duplicate file

```bash
# ~/.config/git folder is not empty
stow git --target ~/.config/git/
# WARNING! stowing git would cause conflicts:
#   * existing target is neither a link nor a directory: config
# All operations aborted.
```

## stow explanation

to manage nested folders you can create a nested .config structure

```
.dotfiles
└── helix
    └── .config
        └── helix
            └── config.toml
```

```bash
# to stow
stow helix
# to unstow
stow -D helix
```

this will symlink the whole helix directory
`helix -> ../.dotfiles/helix/.config/helix`

or instead of creating the nested .config structure, use `--target`

```bash
# to stow
mkdir ~/.config/helix
stow helix --target ~/.config/helix
# to unstow:
stow -D helix --target ~/.config/helix
```

but this does not symlink the whole `helix` directory(it symlinks what's inside it)
so if you add another **file** at the root `helix` folder you have to restow

use `--restow`: Restow packages (first unstow, then stow again) for pruning
obsolete symlinks from the target tree.

for example after deleting config.local we have a broken symlink

```bash
stow --verbose --restow git --target ~/.config/git
# UNLINK: config
# UNLINK: ignore
# UNLINK: config.local
# LINK: config => ../../.dotfiles/git/config (reverts previous action)
# LINK: ignore => ../../.dotfiles/git/ignore (reverts previous action)
```

NOTE: try this
`stow --verbose --restow --target=$HOME --dotfiles $(dirname $0)`
