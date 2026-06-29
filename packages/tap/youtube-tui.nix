{ pkgs ? import <nixpkgs> { } }:

pkgs.youtube-tui.override {
  mpv = pkgs.callPackage ./mpv.nix { };
}