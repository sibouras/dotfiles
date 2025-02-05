#!/usr/bin/env bash

# WARNING: this script is not finished, dont run it!
# TODO: setup git

set -euo pipefail

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/src"
mkdir -p "$HOME/.local/share/bash-completion/completions"
mkdir -p "$HOME/.local/share/zsh-completion"
mkdir -p "$HOME/.local/state/bash" # for bash history file
mkdir -p "$HOME/.local/state/zsh" # for zsh history file

DRA_BIN="$HOME/.local/bin/dra"

# https://github.com/devmatteini/dra
function install_dra(){
  curl --proto '=https' \
    --tlsv1.2 \
    -sSf https://raw.githubusercontent.com/devmatteini/dra/refs/heads/main/install.sh | \
    bash -s -- --to "$DRA_BIN"

  # Post installation setup
  "$DRA_BIN" completion bash > ~/.local/share/bash-completion/completions/dra
  "$DRA_BIN" completion zsh > ~/.local/share/zsh-completion/_dra
  "$DRA_BIN" completion fish > ~/.config/fish/completions/dra.fish
  # Create symlink to be able to use dra as superuser (for example when installing .deb assets)
  sudo ln -sf "$DRA_BIN" /usr/local/bin/dra
}

echo "installing dra...."
install_dra
echo "installed dra"

# install stow
sudo apt install stow

# clone dotfiles repo
git clone https://github.com/sibouras/dotfiles.git ~/.dotfiles
# make sure we're in the .dotfiles directory
cd ~/.dotfiles

# first stow bash and source .bashrc to set XDG environment variables
# backup or remove .bashrc and .profile before stowing
mv ~/.bashrc ~/.bashrc-bak
mv ~/.profile ~/.profile-bak
# the files inside bash belong to the home folder so we don't need --target
stow bash/
source ~/.bashrc

echo "stowing config files"
./stowall.sh
echo "stowing completed"

# install essentials
sudo apt install build-essential xclip zip unzip

# install binaries
./packages/ast-grep
./packages/bat
./packages/delta
./packages/dust
./packages/eza
./packages/fastfetch
./packages/fd
./packages/fnm
./packages/fzf
./packages/git-filter-repo
./packages/gitui
./packages/hyperfine
./packages/lazygit
./packages/moar
./packages/rg
./packages/tldr
./packages/watchexec
./packages/yazi
./packages/zoxide
