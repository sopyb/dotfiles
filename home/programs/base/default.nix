{ self, config, ... }:

{
  imports = [
    (self + /home/programs/command_line)
  ];

  config = {
    home = {
      stateVersion = "24.05";
      username = "sopy";
      homeDirectory = "/home/sopy";
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = true;

      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
      publicShare = "${config.home.homeDirectory}/Public";
      templates = "${config.home.homeDirectory}/Templates";

      extraConfig = {
        games = "${config.home.homeDirectory}/Games";
        torrents = "${config.home.homeDirectory}/Torrents";
      };
    };
  };
}
