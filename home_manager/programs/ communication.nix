{ pkgs, ... }:

let
  vesktop = import ./communication/vesktop.nix { inherit pkgs; };
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