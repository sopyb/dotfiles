{ pkgs, ... }:

{
  imports = [
    ./media/spicetify.nix
  ];

  home.packages = with pkgs; [
    # media
    mpv
    yt-dlp

    # game launchers
    heroic
    itch
    prismlauncher
    steam

    # games
    osu-lazer-bin
    
    # game tools
    discover-overlay
    gamescope
    goverlay
    mangohud

    # wine stuff
    bottles
    protontricks

    # media creation
    kdenlive
    krita
    obs-studio

    # documents
    obsidian
    openboard
    onlyoffice-bin
  ];
}