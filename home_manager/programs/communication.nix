{ pkgs, ... }:

let
  vesktop = import ./communication/vesktop.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    element-desktop
    custom.commet-chat
    teams-for-linux
    thunderbird
    signal-desktop
    slack
    vesktop
    zapzap
    zoom-us
    # zulip
  ];
}
