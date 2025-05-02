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
    # itch
    prismlauncher
    samrewritten
    steam

    # emulators
    # rpcs3

    # games
    osu-lazer-bin

    # game tools
    gamescope
    goverlay
    mangohud

    # wine stuff
    bottles
    protontricks

    # media creation
    kdePackages.kdenlive
    krita
    obs-studio

    # documents
    obsidian
    openboard
    onlyoffice-bin
    libreoffice
  ];
}
