{ config, lib, pkgs, machineName, ... }:

let
  machineUtils = import ../../utils/machineVariables.nix { inherit lib config; };
  machineVars = machineUtils.getMachineVariables machineName;
in
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
      key = machineVars.gitSigningKey;
      format = "openpgp";
      signByDefault = machineVars.gitSigning;
    };

    lfs.enable = true;

  };
}
