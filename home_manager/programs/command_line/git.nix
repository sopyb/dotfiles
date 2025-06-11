{ config, lib, pkgs, machineName, ... }:

let
  machineUtils = import ../../utils/machineVariables.nix { inherit lib config; };
  machineVars = machineUtils.getMachineVariables machineName;
in
{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName = "Sopy";
    userEmail = "contact@sopy.one";

    signing = {
      key = machineVars.gitSigningKey;
      signByDefault = machineVars.gitSigning;
    };

    extraConfig = {
      core = {
        autocrlf = "input";
        # editor = "vim";
      };

      # url = {
      #   "ssh://git@github.com:" = {
      #     insteadOf = "https://github.com/";
      #   };
      # };

      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };
    };

    lfs.enable = true;
    
  };
}
