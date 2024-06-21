{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		nur.url = "github:nix-community/NUR/324a5f3b9fbfdb77336dc9fa1c0a02f33a6acf6d";

		kwin-effects-forceblur = {
			url = "github:taj-ny/kwin-effects-forceblur";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-matlab = {
			inputs.nixpkgs.follows = "nixpkgs";
			url = "gitlab:doronbehar/nix-matlab";
		};

		# spicetify-nix.url = "github:the-argus/spicetify-nix";
	};

  outputs = { self, home-manager, nixpkgs, nix-matlab, nur, ... } @ inputs: #  spicetify-nix,
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs {
			inherit system;
			config.allowUnfree = true;

			overlays = [
				nix-matlab.overlay
			];
		};
		home-manager-args = { inherit inputs pkgs; };
		lib = nixpkgs.lib;
	in {
		nixosConfigurations = {
			alphicta = lib.nixosSystem {
				inherit system;
				modules = [ 
					# To split into modules
					./configuration.nix

					# Modules
          ./system/hw_cfg_victus.nix
					./system/modules/common.nix

					# NUR
					nur.nixosModules.nur

					# Home Manager
					home-manager.nixosModules.home-manager {
							home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							extraSpecialArgs = home-manager-args;

							users.sopy = {
								imports = [
									# ./home_manager/users/common.nix
								];
							};
						};
					}
				];

				specialArgs = {
					inherit inputs pkgs;
				};
			};
		};
	};
}
