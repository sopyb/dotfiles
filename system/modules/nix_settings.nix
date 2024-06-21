{ pkgs, ... }:

{
  imports = [ ];

  config = {

    nix = {
      settings = {
        trusted-users = [ "root" "@wheel" ];
      };
    };
  };

}