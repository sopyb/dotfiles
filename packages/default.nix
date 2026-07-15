{ pkgs }:

{
  commet-chat = pkgs.callPackage ./commet-chat.nix { };
  davinci-resolve-studio = pkgs.callPackage ./davinci-resolve-studio.nix { };
  victus-fan-max = pkgs.callPackage ./victus-fan-max.nix { };
  wattbar = pkgs.callPackage ./wattbar.nix { };
  vesktop = pkgs.callPackage ./vesktop.nix { };

  # thesis
  kitty = pkgs.callPackage ./tap/kitty.nix { };
  mpv-unwrapped = pkgs.callPackage ./tap/mpv-unwrapped.nix { };
  mpv = pkgs.callPackage ./tap/mpv.nix { };
  mpv-music = pkgs.callPackage ./tap/mpv-music.nix { };
}
