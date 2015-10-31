#!/bin/bash

declare realpath="$(which realpath || echo "$(which readlink) -f")"

declare dotfiles="$($realpath "$(dirname $0)")"

link() { ln -sf "$dotfiles/$1" "$HOME/.$1"; }
link_dir() { ln -sfn "$dotfiles/$1" "$HOME/.$1"; }

pushd "$dotfiles" > /dev/null
git submodule update --init
popd > /dev/null

mkdir -p "$HOME/.local/etc"

link bash_profile
link bashrc
link dircolors
link direnvrc
link git-commit-template
link gitconfig
link gitignore
link inputrc
link npmignore
link npmrc
link profile
link vimrc
link_dir vim
