{ pkgs, ... }:

{
  home.packages = with pkgs; [
    custom.commet-chat
    custom.equicord
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
