{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; with kdePackages; [
    krohnkite
  ];
}
