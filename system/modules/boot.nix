
{ pkgs, ... }:

{
  imports = [ ];

  config = {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    boot.kernelPackages = pkgs.linuxPackages_latest;

    system.stateVersion = "24.05";
  };
}
