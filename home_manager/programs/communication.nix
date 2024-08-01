{ pkgs, ... }:

let
  vesktop = import ./communication/vesktop.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    element-desktop
    teams-for-linux
    vesktop
    zapzap
    zulip
    zoom-us
  ];
}