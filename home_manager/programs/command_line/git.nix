{ config, lib, machineName, ... }:

let
  machineUtils = import ../../utils/machineVariables.nix { inherit lib config; };
  machineVars = machineUtils.getMachineVariables machineName;
in
{
  programs.git = {
    enable = true;

    userName = "Sopy";
    userEmail = "contact@sopy.one";

    signing = {
      key = machineVars.gitSigningKey;
      signByDefault = machineVars.gitSigning;
    };

    extraConfig = {
      core = {
        autocrlf = "input";
        editor = "micro";
      };

      url = {
        "ssh://git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}
