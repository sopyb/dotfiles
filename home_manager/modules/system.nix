{ lib, ... }:

{
  imports = [
    ../programs/command_line.nix
  ];

  config = {
    home.stateVersion = "24.05";
    home.username = "sopy";
    home.homeDirectory = "/home/sopy";
  };
}