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

  # Common wayland packages
  home.packages = with pkgs; [
    brightnessctl
    wl-clipboard
    wev # for debugging
  ];
}
