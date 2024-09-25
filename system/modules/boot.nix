
{ pkgs, inputs, system, ... }:

let
  grub-theme = inputs.distro-grub-themes.packages.${system}.nixos-grub-theme;
in
{
  imports = [ ];

  config = {
    boot.loader = rec {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;

        theme = grub-theme;
        splashImage = "${grub-theme}/splash_image.jpg";        
      };
      
      efi.canTouchEfiVariables = true;
    };
    boot.kernelPackages = pkgs.linuxPackages_latest;

    system.stateVersion = "24.05";
  };
}
