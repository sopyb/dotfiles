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

		
        distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";

	    spicetify-nix = {
          url = "github:Gerg-L/spicetify-nix";
          inputs.nixpkgs.follows = "nixpkgs";
        };
	};

  outputs = { self, home-manager, nixpkgs, ... } @ inputs: 
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs {
			inherit system;
			config.allowUnfree = true;

			overlays = with inputs; [
				nix-matlab.overlay
				nixos-cosmic.overlays.default
			];
		};
		home-manager-args = { inherit inputs pkgs; };
		lib = nixpkgs.lib;
	in {
		nixosConfigurations = {
			alphicta = lib.nixosSystem {
				inherit system;

				modules = [ 
					# Modules
					./system/hw_cfg_victus.nix
					./system/modules/common.nix

					# Desktop Environment
					./system/modules/desktop/cosmic.nix

					({networking.hostName = "alphicta";})

					# Home Manager
					home-manager.nixosModules.home-manager {
							home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							extraSpecialArgs = home-manager-args;
							backupFileExtension = "old";

							users.sopy = {
								imports = [ 
									./home_manager/modules/system.nix
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
	};
}
