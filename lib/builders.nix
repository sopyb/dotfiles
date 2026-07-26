{ inputs, self }:

let
  lib = inputs.nixpkgs.lib;

  pkgsForSystem = system: import inputs.nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
      android_sdk.accept_license = true;

      permittedInsecurePackages = [
        "electron-39.8.10"
      ];
    };
    overlays = [
      (import (self + /overlays/default.nix) { inherit inputs self; })
      inputs.emerald-launcher.overlays.default
      inputs.niri.overlays.niri
      inputs.nur.overlays.default
    ];
  };

  mkMachine = { name, system ? "x86_64-linux" }:
    let
      machineConfig = import (self + "/machines/${name}/config.nix");
    in
    lib.nixosSystem {
      modules = [
        (self + "/machines/${name}")
        (self + /lib/make-machine.nix)
        { nixpkgs.pkgs = pkgsForSystem system; }
      ];

      specialArgs = {
        inherit inputs system self;
        inherit (inputs) home-manager;
        machine = machineConfig.machine;
      };
    };

in
{
  inherit pkgsForSystem mkMachine;
}
