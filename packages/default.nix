{ pkgs }:

{
  commet-chat = pkgs.callPackage ./commet-chat.nix { };
  davinci-resolve-studio = pkgs.callPackage ./davinci-resolve-studio.nix { };
  wattbar = pkgs.callPackage ./wattbar.nix { };

  # thesis
  mpv-unwrapped = pkgs.callPackage ./tap/mpv-unwrapped.nix { };
  kitty = pkgs.callPackage ./tap/kitty.nix { };
}
