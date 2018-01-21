#!/bin/sh

if ! command -v nix-env >/dev/null 2>&1; then
    nix_installer=$(mktemp)
    curl -s https://nixos.org/nix/install > $nix_installer
    sh $nix_installer
fi

if [ -d .git ] && command -v git >/dev/null 2>&1
then
    git pull origin master || true
fi

if ! [ -f default.nix ] && command -v git >/dev/null 2>&1; then
    mkdir -p $HOME/.local/share
    repo_dir=$HOME/.local/share/bauer
    git clone https://github.com/matthewbauer/bauer $repo_dir
    cd $repo_dir
fi

nix-env -if .
