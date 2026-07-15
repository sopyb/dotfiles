{ pkgs, ... }:

{
  home.packages = with pkgs; [
    custom.commet-chat
    custom.vesktop
    element-desktop
    teams-for-linux
    thunderbird
    signal-desktop
    slack
    zapzap
    zoom-us
    # zulip
  ];
}
