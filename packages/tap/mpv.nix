{ pkgs ? import <nixpkgs> { } }:

pkgs.mpv.override {
  mpv-unwrapped = pkgs.callPackage ./mpv-unwrapped.nix { };
}