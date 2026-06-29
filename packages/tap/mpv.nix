{ pkgs ? import <nixpkgs> { } }:

pkgs.mpv.override {
  mpv-unwrapped = pkgs.callPackage ./mpv-unwrapped.nix { };
  extraMakeWrapperArgs = [ "--add-flags" "--ao=tap" ];
}