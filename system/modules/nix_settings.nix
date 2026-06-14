{ pkgs, ... }:

{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];

      substituters = [
        "https://cache.lix.systems"
        "https://cache.nixos.org/"
        "https://hyprland.cachix.org"
        "https://noctalia.cachix.org"
      ];

      trusted-public-keys = [
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];

      binary-caches-parallel-connections = 10;

      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d --keep 5";
    };

    package = pkgs.lix;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
