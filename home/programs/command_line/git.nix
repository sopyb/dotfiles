{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    settings = {
      user = {
        name = "Sopy";
        email = "contact@sopy.one";
      };


      core = {
        autocrlf = "input";
        editor = "micro";
      };

      # url = {
      #   "ssh://git@github.com:" = {
      #     insteadOf = "https://github.com/";
      #   };
      # };
    };

    signing = {
      key = config.machine.variables.gitSigningKey;
      format = "openpgp";
      signByDefault = config.machine.variables.gitSigning;
    };

    lfs.enable = true;

  };
}
