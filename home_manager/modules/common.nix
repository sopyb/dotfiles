{ ... }:

{
  imports = [
    ../programs/command_line.nix
  ];

  config.home = {
    stateVersion = "24.05";
    username = "sopy";
    homeDirectory = "/home/sopy";
  };
}
