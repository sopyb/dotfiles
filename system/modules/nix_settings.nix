{ pkgs, ... }:

{
  imports = [ ];

  config = {

    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [ "root" "@wheel" ];

        substituters = ["https://cosmic.cachix.org/"];
        trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
      };

      package = pkgs.nixFlakes;

      extraOptions = ''
        experimental-features = nix-command flakes
        binary-caches-parallel-connections = 5
      '';
    };
  };

}