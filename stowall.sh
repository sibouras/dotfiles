#!/usr/bin/env bash

set -euo pipefail

# make sure we're in the .dotfiles directory
cd ~/.dotfiles

# stow zsh
# make sure directory exists before stowing
mkdir -p ~/.config/zsh
# there is no way around having the one file that sets ZDOTDIR be in the default location.
ln -sf .dotfiles/.zshenv "$HOME/.zshenv"
stow zsh/ --target ~/.config/zsh/

mkdir -p ~/.config/helix
stow helix/ --target ~/.config/helix/

mkdir -p ~/.config/git
stow git/ --target ~/.config/git/

mkdir -p ~/.config/gitui
stow gitui/ --target ~/.config/gitui/

mkdir -p ~/.config/fish
stow fish/ --target ~/.config/fish/

mkdir -p ~/.local/wsl-scripts
stow wsl-scripts/ --target ~/.local/wsl-scripts/

mkdir -p ~/.config/yazi
stow yazi/ --target ~/.config/yazi/

mkdir -p ~/.config/lazygit
stow lazygit/ --target ~/.config/lazygit/

mkdir -p ~/.config/cheat
stow cheat/ --target ~/.config/cheat/
