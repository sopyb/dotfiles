{ pkgs, ... }:

let
  utils = import ./programming/utils.nix { inherit pkgs; };
in {
  home.packages = with pkgs; [
    arduino-ide
    matlab
    vscode
    android-studio

    # Rust toolchain
    rustup
  ] ++ utils.addJetbrainsPlugins [
    # android-studio
    jetbrains.clion ## llvm & university work
    jetbrains.webstorm ## random web projects - Portfolio time
    # jetbrains.rust-rover ## sheesh
    jetbrains.pycharm-professional ## not python... NOT PYTHON
    # jetbrains.phpstorm ## Universuty work
    # jetbrains.idea-ultimate ## University work
    jetbrains.datagrip ## University work
    jetbrains.goland
  ];
}
