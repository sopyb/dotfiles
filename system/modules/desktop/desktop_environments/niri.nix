{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  programs.niri.enable = true;

  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };
}
