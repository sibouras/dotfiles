# My dotfiles

## Installation

```bash
git clone link .dotfiles
cd .dotfiles
```

then use GNU stow to create symlinks

```bash
# the files inside bash belong to the home folder so we don't need --target
stow bash/

# .zshenv needs to load before .zshrc
ln -s .dotfiles/.zshenv ../.zshenv
# before using --target create an empty ~/.config/zsh
stow zsh/ --target ~/.config/zsh

stow helix/ --target ~/.config/helix/
stow git/ --target ~/.config/git/
stow gitui/ --target ~/.config/gitui/
stow fish/ --target ~/.config/fish/
```

## Explanation

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
stow helix --target=~/.config/helix
# to unstow:
stow -D helix --target=~/.config/helix
```

but this does not symlink the whole `helix` directory(it symlinks what's inside it)
so if you add another file at the root `helix` folder you have to restow

NOTE: try this
`stow --verbose --restow --target=$HOME --dotfiles $(dirname $0)`
