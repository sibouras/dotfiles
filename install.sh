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
mkdir -p "$HOME/.local/state/zsh"  # for zsh history file

DRA_BIN="$HOME/.local/bin/dra"

# Change to the directory of this script
cd "$(dirname "$0")"

# symlink configs
./dotlink.sh
mkdir -p "$HOME/.config/fish/completions"

# if running inside wsl
if command -v wslinfo &> /dev/null; then
  ln -sf /mnt/c/Windows/System32/clip.exe ~/.local/bin
fi

# https://github.com/devmatteini/dra
function install_dra() {
  curl --proto '=https' \
    --tlsv1.2 \
    -sSf https://raw.githubusercontent.com/devmatteini/dra/refs/heads/main/install.sh |
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

# some install scripts like fnm install stuff in XDG_DATA_HOME if it's set
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# append ~/.local/bin to path so scripts that generate completions work
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# apt packages
if command -v apt &> /dev/null; then
  # install essentials
  sudo apt install build-essential xclip zip unzip

  # install binaries
  ./packages/bat
  ./packages/btop
  ./packages/delta
  ./packages/dust
  ./packages/eza
  ./packages/fastfetch
  ./packages/fd
  ./packages/fnm
  ./packages/fzf
  ./packages/gitui
  ./packages/hyperfine
  ./packages/lazygit
  ./packages/moor
  ./packages/ouch
  ./packages/resvg
  ./packages/rg
  ./packages/tldr
  ./packages/vivid
  ./packages/watchexec
  ./packages/yazi
  ./packages/zoxide
fi
