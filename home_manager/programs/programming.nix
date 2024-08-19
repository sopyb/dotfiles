{ pkgs, ... }:

let
  utils = import ./programming/utils.nix { inherit pkgs; };
in {
  home.packages = with pkgs; [
    arduino-ide
    matlab
    vscode
  ] ++ utils.addJetbrainsPlugins [
    jetbrains.clion
    # jetbrains.webstorm
    # jetbrains.rust-rover
    # jetbrains.pycharm-professional
    # jetbrains.phpstorm
    # jetbrains.idea-ultimate
    # jetbrains.datagrip
  ];
}