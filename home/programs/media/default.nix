{ pkgs, ... }:

{
  imports = [
    # ./spicetify.nix
    ./zen-browser.nix
  ];

  home.packages = with pkgs; with kdePackages;[
    # media
    custom.mpv
    custom.mpv-music
    yt-dlp
    pear-desktop
    chatterino7
    easyeffects

    # browsers
    google-chrome
    firefox-devedition
    vivaldi
    vivaldi-ffmpeg-codecs

    # game launchers
    heroic
    # itch
    prismlauncher
    fork.emerald-legacy-launcher
    samrewritten
    steam

    # mod managers
    olympus
    r2modman

    # emulators
    # xemu
    # xenia-canary
    # rpcs3

    # games
    osu-lazer-bin

    # game tools
    gamescope
    goverlay
    mangohud

    # wine stuff
    stable.bottles
    protontricks

    # media creation
    ardour
    # custom.davinci-resolve-studio
    kdenlive
    krita
    inkscape
    obs-studio

    stable.blender
    # unityhub
    godot

    # documents
    obsidian
    # openboard
    libreoffice-qt6-fresh
    onlyoffice-desktopeditors
    zotero
  ];
}
