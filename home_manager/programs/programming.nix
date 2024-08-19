{ pkgs, ... }:

let
  programsUtils = inherit (import ./programming/utils.nix);
in {
  home.packages = with pkgs; [
    programsUtils.addJetbrainsPlugins [
      jetbrains.clion
      # jetbrains.webstorm
      # jetbrains.rust-rover
      # jetbrains.pycharm-professional
      # jetbrains.phpstorm
      # jetbrains.idea-ultimate
      # jetbrains.datagrip
    ]
  ];
}