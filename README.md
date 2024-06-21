# NixOS dotfiles

This repository contains my dotfiles for my NixOS system.

# Installation

## Enable nix-command and flakes
```bash
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

## Rebuild system
Available devices:
- alphicta (my Victus 16-e0003nq laptop)

```bash
sudo nixos-rebuild switch --flake .#<hostname>
``` 

You can update the pinned flake packages with `nix flake update`. 

## Note to self...
```bash
git submodule init
git submodule update
```

Initialize and update the submodule