{ pkgs, ... }:

{
  imports = [
    ./command_line/direnv.nix
    # ./command_line/eza.nix
    ./command_line/htop.nix
    ./command_line/hyfetch.nix
    ./command_line/zip_utils.nix
    ./command_line/zsh.nix
  ];

  home.packages = with pkgs; [
    # random stuff
    blahaj
    ponysay

    # network stuff
    curl
    wget

    # wayland
    wl-clipboard
  ];
}