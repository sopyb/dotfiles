{ pkgs }:

{
  commet-chat = pkgs.callPackage ./commet-chat.nix { };
  davinci-resolve-studio = pkgs.callPackage ./davinci-resolve-studio.nix { };
  wattbar = pkgs.callPackage ./wattbar.nix { };

  # thesis
  kitty = pkgs.callPackage ./tap/kitty.nix { };
  mpv-unwrapped = pkgs.callPackage ./tap/mpv-unwrapped.nix { };
  mpv = pkgs.callPackage ./tap/mpv.nix { };
  mpv-music = pkgs.callPackage ./tap/mpv-music.nix { };
}
