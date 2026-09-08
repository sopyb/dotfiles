# NixOS dotfiles
> [!WARNING]
> I have no idea what I am doing >.> but feel free to look around

# Installation

## Enable nix-command and flakes
```bash
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

## Rebuild system
Available devices:
- alphicta (my Victus 16-e0003nq laptop)
- zetalyeh (ryzen 9 5900x - 3080 pc)

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

You can update the pinned flake packages with `nix flake update`.

## Todo:
- Rewrite deckmode specialization to be more system agnostic and actually functional instead of barely functional --- deprecated till them

## License

This repository is under the MIT license, [Read more here](./LICENSE).
