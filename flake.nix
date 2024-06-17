{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		nur.url = "github:nix-community/NUR/324a5f3b9fbfdb77336dc9fa1c0a02f33a6acf6d";

		kwin-effects-forceblur = {
			url = "github:taj-ny/kwin-effects-forceblur";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-matlab = {
			inputs.nixpkgs.follows = "nixpkgs";
			url = "gitlab:doronbehar/nix-matlab";
		};

		spicetify-nix.url = "github:the-argus/spicetify-nix";
	};

  outputs = { self, nixpkgs, nix-matlab, nur, spicetify-nix, ... } @ inputs:
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs {
			inherit system;
			config.allowUnfree = true;

			overlays = [
				nix-matlab.overlay
			];
		};
		lib = nixpkgs.lib;
	in {
		nixosConfigurations = {
			alphicta = lib.nixosSystem {
				inherit system;
				modules = [ 
          ./system/hw_cfg_victus.nix
					./configuration.nix
					nur.nixosModules.nur
				];

				specialArgs = { 
					inherit inputs pkgs;
					# matlab = nix-matlab.defaultPackage.${system};
				};
			};
		};
	};
}
