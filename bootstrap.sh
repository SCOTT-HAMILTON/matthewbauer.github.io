
#!/bin/sh

if ! command -v nix-env >/dev/null 2>&1; then
    nix_installer=$(mktemp)
    curl -s https://nixos.org/nix/install > $nix_installer
    sh $nix_installer
fi

if [ -d .git ]; then
    git pull origin master
fi

if ! [ -f default.nix ]; then
    repo_dir=$(mktemp -d)
    git clone https://github.com/matthewbauer/bauer $repo_dir
    cd $repo_dir
fi

nix-env -if .
