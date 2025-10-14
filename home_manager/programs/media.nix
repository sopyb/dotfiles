{ pkgs, ... }:

{
  imports = [
    # ./media/spicetify.nix
  ];

  programs.zen-browser = {
    enable = true;

    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
    };
  };





  home.packages = with pkgs; [
    # media
    mpv
    yt-dlp
    youtube-music

    # browsers
    google-chrome
    firefox-devedition
    vivaldi
    vivaldi-ffmpeg-codecs
    ladybird

    # game launchers
    heroic
    # itch
    prismlauncher
    samrewritten
    steam
    alvr

    # emulators
    # xemu
    xenia-canary
    rpcs3

    # games
    olympus
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

    blender
    # unityhub
    godot

    # documents
    obsidian
    # openboard
    libreoffice-qt6-fresh
    onlyoffice-bin
  ];
}
