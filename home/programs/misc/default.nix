{ pkgs, ... }:
# quite literally the idk how to cattegorize this stuff category
{
  home.packages = with pkgs; [
    kdePackages.filelight
    kdePackages.partitionmanager
    kdePackages.plasma-systemmonitor
    kdePackages.ark

    bitwarden-cli
    bitwarden-desktop

    tor-browser
    qbittorrent

    piper

    # winboat
  ];
}
