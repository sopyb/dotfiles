
{ config, ... }:

{
  imports = [ ];

  config = {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Randomly decided the NixOS version should be here.
    system.stateVersion = "24.05";
  };
}
