{ pkgs }:

{
  commet-chat = pkgs.callPackage ./commet-chat.nix { };
  davinci-resolve-studio = pkgs.callPackage ./davinci-resolve-studio.nix { };
  equicord = pkgs.callPackage ./equicord.nix { };
  linver = pkgs.callPackage ./linver.nix { };
  victus-fan-max = pkgs.callPackage ./victus-fan-max.nix { };
  wattbar = pkgs.callPackage ./wattbar.nix { };

  # thesis
  kitty = pkgs.callPackage ./tap/kitty.nix { };
  mpv-unwrapped = pkgs.callPackage ./tap/mpv-unwrapped.nix { };
  mpv = pkgs.callPackage ./tap/mpv.nix { };
  mpv-music = pkgs.callPackage ./tap/mpv-music.nix { };
}
