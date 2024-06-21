{ pkgs, ... }:

{
  imports = [ ];

  config = {

    nix = {
      settings = {
        trustedUsers = [ "root" "@wheel" ];
      };
    };
  };

}