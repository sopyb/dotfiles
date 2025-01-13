{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Todo: remove once https://github.com/NixOS/nixpkgs/pull/370339 is merged
    nixpkgs_nvidia470.url = "github:Kiskae/nixpkgs/nvidia/legacy_kernel_6_12";

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

  };

  outputs = { self, home-manager, nixpkgs, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
          android_sdk.accept_license = true;
        };

        overlays = with inputs; [
          nix-matlab.overlay
          nixos-cosmic.overlays.default
        ];
      };
      home-manager-args = { inherit inputs pkgs; };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        alphicta = lib.nixosSystem {
          inherit system;

          modules = [
            # Modules
            ./system/hw_cfg_alphicta.nix
            ./system/modules/desktop.nix
            ./system/modules/virtualization.nix

            # Desktop Environment
            ./system/modules/desktop/desktop_environments/cosmic.nix
            ./system/modules/desktop/display_managers/cosmic-greeter.nix

            # specializations
            # ./system/specializations/deckmode.nix

            ({ networking.hostName = "alphicta"; })

            # Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = home-manager-args // {
                  machineName = "alphicta";
                };
                backupFileExtension = "old2";

                users.sopy = {
                  imports = [
                    ./home_manager/modules/desktop.nix
                  ];
                };
              };
            }
          ];

          specialArgs = {
            inherit inputs pkgs system;
          };
        };

        bethium = lib.nixosSystem {
          inherit system;

          modules = [
            # Modules
            ./system/hw_cfg_bethium.nix
            ./system/modules/desktop.nix

            # Desktop Environment
            ./system/modules/desktop/desktop_environments/gnome.nix

            ({ networking.hostName = "bethium"; })

            # Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = home-manager-args // {
                  machineName = "bethium";
                };
                backupFileExtension = "old2";

                users.sopy = {
                  imports = [
                    ./home_manager/modules/desktop.nix
                  ];
                };
              };
            }
          ];

          specialArgs = {
            inherit inputs pkgs system;
          };
        };

        zetalyeh = lib.nixosSystem {
          inherit system;

          modules = [
            # Modules
            ./system/hw_cfg_zetalyeh.nix
            ./system/modules/server.nix

            # Desktop Environment
            ./system/modules/desktop/desktop_environments/xfce.nix

            ({ networking.hostName = "zetalyeh"; })

            # Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = home-manager-args // {
                  machineName = "zetalyeh";
                };
                backupFileExtension = "old2";

                users.sopy = {
                  imports = [
                    ./home_manager/modules/server.nix
                  ];
                };
              };
            }
          ];

          specialArgs = {
            inherit inputs pkgs system;
          };
        };
      };


      homeConfigurations.sopy = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          {
            home = {
              username = "sopy";
              homeDirectory = "/home/sopy";
            };

            imports = [
              ./home_manager/modules/system.nix
            ];

            programs.home-manager.enable = true;

            # Update desktop database after changes
            home.activation = {
              updateDesktopDatabase = {
                after = [ "linkGeneration" ];
                before = [ ];
                data = ''
                  $DRY_RUN_CMD ${pkgs.desktop-file-utils}/bin/update-desktop-database $HOME/.local/share/applications
                '';
              };
            };
          }
        ];

        extraSpecialArgs = {
          inherit inputs pkgs system;
        };
      };
    };
}
