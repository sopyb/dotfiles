{ pkgs, ... }:
# quite literally the idk how to cattegorize this stuff category
{
  home.packages = with pkgs; [
    kdePackages.filelight
    kdePackages.partitionmanager
    kdePackages.plasma-systemmonitor
    kdePackages.ark


    tor-browser
    deluge
    
    floorp
    google-chrome
    # firefox-devedition
    # vivaldi
    # vivaldi-ffmpeg-codecs
    # ladybird
  ];
}
