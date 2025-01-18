# NixOS dotfiles
> [!WARNING]
> I have no idea what I am doing >.> but feel free to look around

This repository contains my dotfiles for my NixOS system.

# Installation

## Enable nix-command and flakes
```bash
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

## Rebuild system
Available devices:
- alphicta (my Victus 16-e0003nq laptop)
- bethium (office all-in-one pc)
- zetalyeh ("server" machine under my desk - formerly chtulhu)

```bash
sudo nixos-rebuild switch --flake .#<hostname>
``` 

You can update the pinned flake packages with `nix flake update`. 

## Hostname Origins
The hostnames follow a Greek letter + mythology/reference naming scheme:

- **alphicta**: From "alpha" (first) + "invicta" (undefeated/invincible)
  - Named for surviving multiple DIY repairs including drilled holes when hinges failed 

- **bethium**: From "beta" + "-ium" (element suffix like Ruthenium)

- **zetalyeh**: From "zeta" + "R'lyeh" (Lovecraft's sunken city)
  - Previously named "chtulhu" - because of how janky it is
  - Now you too can experience 2010 again... 

## License 

This repository is under the MIT license, [Read more here](./LICENSE).