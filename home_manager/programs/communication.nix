{ pkgs, ... }:

let
  vesktop = import ./communication/vesktop.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    element-desktop
    teams-for-linux
    thunderbird
    slack
    vesktop
    zapzap
    zoom-us
    # zulip
  ];
}
