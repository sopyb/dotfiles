{ pkgs, ... }:

{
  imports = [
    # ./media/spicetify.nix
    ./media/zen-browser.nix
  ];

  home.packages = with pkgs; [
    # media
    mpv
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
    bottles
    protontricks

    # media creation
    custom.davinci-resolve-studio
    krita
    inkscape
    obs-studio

    blender
    # unityhub
    godot

    # documents
    obsidian
    # openboard
    libreoffice-qt6-fresh
    onlyoffice-desktopeditors
  ];
}
