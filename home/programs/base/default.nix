{ self, ... }:

{
  imports = [
    (self + /home/programs/command_line)
  ];

  config.home = {
    stateVersion = "24.05";
    username = "sopy";
    homeDirectory = "/home/sopy";
  };
}
