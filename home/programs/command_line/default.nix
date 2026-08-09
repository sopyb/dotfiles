{ pkgs, ... }:

{
  imports = [
    ./archive_utils.nix
    ./direnv.nix
    ./eza.nix
    ./git.nix
    ./gpg.nix
    ./htop.nix
    ./hyfetch.nix
    ./kitty.nix
    ./micro.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    # random stuff
    killall
    ffmpeg
    poppler-utils
    pulsemixer
    jq
    yq

    # nix stuff
    cachix
    nix-prefetch-github
    nix-prefetch-git
    nix-tree

    # android screneshare stuff
    android-tools
    scrcpy

    # network stuff
    curl
    wget

    # wayland
    wl-clipboard
    wl-gammactl

    # Nix stuff
    nixpkgs-fmt
    nil

    # bluetooth stuff
    bluetuith

    # Work stuff
    # picocom
  ];
}
