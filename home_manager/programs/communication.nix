{ pkgs, ... }:

let
  vesktop = import ./communication/vesktop.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    custom.commet-chat
    element-desktop
    teams-for-linux
    thunderbird
    signal-desktop
    slack
    vesktop
    stable.zapzap
    zoom-us
    # zulip
  ];
}
