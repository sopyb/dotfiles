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

## File Structure

### Root Directory (/)
- `flake.nix` - Main flake configuration file
- `flake.lock` - Tracks pinned dependencies versions

### /flakes/
Development environment flakes used with direnv that can be symlinked into project directories

Mandatory, command so I don't forget:
```sh
ln -s ~/dotfiles/flakes/llvm.flake ./flake.nix
```

### /home-manager/
User-specific configurations managed by home-manager:

#### modules/
- `common.nix` - Shared configurations across all profiles
- `desktop.nix` - Desktop-specific settings
- `server.nix` - Server-specific settings

#### programs/
- `command_line/` - Terminal utilities (zsh, git, gpg, etc.)
- `communication/` - Messaging apps (vesktop)
- `media/` - Media players and tools (spicetify)
- `programming/` - Development environment setup
- `misc.nix` - Other program configurations

#### utils/
- `machineVariables.nix` - Host-specific variables and settings

### /system/
System-wide NixOS configurations:

#### hardware/
- GPU drivers (AMD, NVIDIA)
- Input devices (controllers, tablet)
- System components (bluetooth)

#### Host Configurations
- `hw_cfg_alphicta.nix` - Laptop configuration
- `hw_cfg_bethium.nix` - Desktop configuration  
- `hw_cfg_zetalyeh.nix` - Server configuration

#### modules/
- `desktop/` - Window managers and display configurations
- `server/` - Server services and settings 
- Core system modules (boot, fonts, users, etc.)

#### specializations/
- `deckmode/` - Steam Deck-like interface configuration

## License 

This repository is under the MIT license, [Read more here](./LICENSE).