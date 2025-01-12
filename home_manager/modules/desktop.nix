{ ... }:

{
  imports = [
    ./common.nix

    ../programs/communication.nix
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
  