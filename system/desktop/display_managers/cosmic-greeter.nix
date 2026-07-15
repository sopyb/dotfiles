{ config, inputs, lib, pkgs, ... }:

{
  imports = [ inputs.nixos-cosmic.nixosModules.default ];

  services.displayManager.cosmic-greeter.enable = true;
}
