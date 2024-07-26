{ lib, ... }:

{
  imports = [
    ../programs/htop.nix
  ]

  config = {
    home.stateVersion = "24.05";
    home.username = "sopy";
    home.homeDirectory = "/home/sopy";
  };
}