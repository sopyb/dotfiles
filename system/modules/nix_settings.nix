{ pkgs, ... }:

{
  imports = [ ];

  config = {

    nix = {
      settings = {
        trusted-users = [ "root" "@wheel" ];
      };

      package = pkgs.nixFlakes;

      extraOptions = ''
        experimental-features = nix-command flakes
        binary-caches-parallel-connections = 5
      '';
    };
  };

}