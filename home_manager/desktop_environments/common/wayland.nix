{ pkgs, ... }:

let
  anyrun = import ./anyrun.nix;
  swayosd = import ./swayosd.nix;
  swaync = import ./swaync.nix;
  wattbar = import ./wattbar.nix;
in
{
  imports = [
    anyrun.module
    swaync.module
    swayosd.module
    wattbar.module
  ];

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.macchiatoLavender;
    name = "catppuccin-macchiato-lavender-cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Common wayland packages
  home.packages = with pkgs; [
    brightnessctl
    wl-clipboard
    wev # for debugging
  ];
}
