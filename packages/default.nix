{ pkgs }:

{
  commet-chat = pkgs.callPackage ./commet-chat.nix { };
  davinci-resolve-studio = pkgs.callPackage ./davinci-resolve-studio.nix { };
  wattbar = pkgs.callPackage ./wattbar.nix { };

  # thesis
  kitty = pkgs.callPackage ./tap/kitty.nix { };
  mpv-unwrapped = pkgs.callPackage ./tap/mpv-unwrapped.nix { };
  mpv = pkgs.callPackage ./tap/mpv.nix { };
  youtube-tui = pkgs.callPackage ./tap/youtube-tui.nix { };
}
