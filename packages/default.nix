{ pkgs }:

{
  davinci-resolve-studio = pkgs.callPackage ./davinci-resolve-studio.nix { };
  wattbar = pkgs.callPackage ./wattbar.nix { };
}
