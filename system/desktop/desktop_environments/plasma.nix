{ inputs, pkgs, ... }:

{
  imports = [
    inputs.aerothemeplasma-nix.nixosModules.aerothemeplasma-nix
  ];

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; with kdePackages; [
    krohnkite

    custom.linver
  ];

  programs.aeroshell = {
    enable = true;
    fonts.segoe.enable = true;
    polkit.enable = true;
    aerothemeplasma = {
      enable = true;
      sddm.enable = true;
      plymouth.enable = true;
    };
  };

  services.displayManager.defaultSession = "aerothemeplasma";
}
