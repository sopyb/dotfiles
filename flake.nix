{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-matlab = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "gitlab:doronbehar/nix-matlab";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minesddm = {
      url = "github:sopyb/sddm-theme-minesddm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minegrub-world-sel-theme = {
      url = "github:Lxtharia/minegrub-world-sel-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, home-manager, nixpkgs, ... } @ inputs:
    let
      lib = nixpkgs.lib;

      # Create a function to generate pkgs for different systems
      pkgsForSystem = system: import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
          android_sdk.accept_license = true;
        };
        overlays = with inputs; [
          nix-matlab.overlay
          nixos-cosmic.overlays.default
          nur.overlays.default
        ];
      };

      mkMachine = { name, hardwareConfig, machineConfig, system ? "x86_64-linux" }:
        let
          # Create architecture-specific packages for this machine
          machinePackages = pkgsForSystem system;
        in
        lib.nixosSystem {
          inherit system;

          modules = [
            # Machine configuration
            hardwareConfig
            ./lib/make-machine.nix
            machineConfig

            # Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; } // {
                  machineName = name;
                  inherit system;
                  machine = machineConfig.machine;
                  pkgs = machinePackages;
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
            pkgs = machinePackages;
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
                ollama = true;
                deckmode = true;
                noDGPUspecialization = true;
              };
              desktopEnvironment = {
                enable = true;
                type = "hyprland";
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
                type = "gnome";
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
                type = "xfce";
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
