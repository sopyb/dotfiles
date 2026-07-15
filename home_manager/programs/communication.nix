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
    vesktop
    stable.zapzap
    zoom-us
    # zulip
  ];
}
