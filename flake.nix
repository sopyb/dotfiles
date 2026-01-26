{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minesddm = {
      url = "github:Davi-S/sddm-theme-minesddm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minegrub-world-sel-theme = {
      url = "github:Lxtharia/minegrub-world-sel-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wattbar = {
      url = "github:thequux/wattbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    nur.url = "github:nix-community/NUR";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    vgpu4nixos.url = "github:mrzenc/vgpu4nixos";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, home-manager, nixpkgs, nixpkgs-stable, ... } @ inputs:
    let
      lib = nixpkgs.lib;

      overlaysModule = import ./overlays/default.nix { inherit inputs; };

      pkgsForSystem = system: import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
          android_sdk.accept_license = true;
        };
        overlays = [
          inputs.nur.overlays.default
          overlaysModule
        ];
      };

      mkMachine = { name, hardwareConfig, machineConfig, system ? "x86_64-linux" }:
        let
          machinePackages = pkgsForSystem system;
        in
        lib.nixosSystem {
          modules = [
            # Machine configuration
            hardwareConfig
            ./lib/make-machine.nix
            machineConfig
            { nixpkgs.pkgs = machinePackages; }
            # nixpkgs.nixosModules.readOnlyPkgs

            # Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs system;
                  machineName = name;
                  machine = machineConfig.machine;
                };
                backupFileExtension = "old";

                users.sopy = {
                  imports = [
                    ./lib/make-home.nix
                  ];
                };
              };
            }
          ];

          specialArgs = {
            inherit inputs system;
            machine = machineConfig.machine;
          };
        };
    in
    {
      nixosConfigurations = {
        alphicta = mkMachine {
          name = "alphicta";
          hardwareConfig = ./system/hw_cfg_alphicta.nix;
          machineConfig = {
            machine = {
              name = "alphicta";
              type = "desktop";
              features = {
                virtualization = true;
                deckmode = true;
                noDGPUspecialization = true;
              };
              desktopEnvironment = {
                enable = true;
                types = [ "hyprland" "cosmic" ];
                displayManager = "ly";
              };
            };
          };
        };

        bethium = mkMachine {
          name = "bethium";
          hardwareConfig = ./system/hw_cfg_bethium.nix;
          machineConfig = {
            machine = {
              name = "bethium";
              type = "desktop";
              features = { };
              desktopEnvironment = {
                enable = true;
                types = [ "gnome" ];
                displayManager = "none";
              };
            };
          };
        };

        zetalyeh = mkMachine {
          name = "zetalyeh";
          hardwareConfig = ./system/hw_cfg_zetalyeh.nix;
          machineConfig = {
            machine = {
              name = "zetalyeh";
              type = "hybrid";
              features = { };
              desktopEnvironment = {
                enable = true;
                types = [ "xfce" ];
                displayManager = "ly";
              };
            };
          };
        };

        omegantes = mkMachine {
          name = "omegantes";
          system = "aarch64-linux";
          hardwareConfig = ./system/hw_cfg_omegantes.nix;
          machineConfig = {
            machine = {
              name = "omegantes";
              type = "server";
              features = { };
              desktopEnvironment.enable = false;
            };
          };
        };
      };
    };
}
