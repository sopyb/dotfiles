{ pkgs, ... }:

{
  imports = [
    ./command_line/archive_utils.nix
    ./command_line/direnv.nix
    ./command_line/eza.nix
    ./command_line/git.nix
    ./command_line/gpg.nix
    ./command_line/htop.nix
    ./command_line/hyfetch.nix
    ./command_line/kitty.nix
    ./command_line/micro.nix
    ./command_line/zsh.nix
  ];

  home.packages = with pkgs; [
    # random stuff
    blahaj
    killall
    ponysay
    ffmpeg
    peaclock

    # android screneshare stuff
    android-tools
    scrcpy

    # network stuff
    curl
    wget

    # wayland
    wl-clipboard

    # Nix stuff
    nixpkgs-fmt
    nil

    # Work stuff
    picocom
  ];
}
