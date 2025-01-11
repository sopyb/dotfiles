{ ... }:

{
  imports = [
    ../programs/communication.nix
    ../programs/command_line.nix
    ../programs/media.nix
    ../programs/misc.nix
    ../programs/programming.nix
  ];

  config = {
    home.stateVersion = "24.05";
    home.username = "sopy";
    home.homeDirectory = "/home/sopy";
  };
}
  