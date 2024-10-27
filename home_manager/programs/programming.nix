{ pkgs, ... }:

let
  utils = import ./programming/utils.nix { inherit pkgs; };
in {
  home.packages = with pkgs; [
    arduino-ide
    matlab
    vscode

    # Rust toolchain
    rustup

    # D stuff
    dmd
    ldc
    dtools
    serve-d
  ] ++ utils.addJetbrainsPlugins [
    jetbrains.clion ## llvm & university work
    jetbrains.webstorm ## random web projects - Portfolio time
    jetbrains.rust-rover ## sheesh
    # jetbrains.pycharm-profesasional ## not python... NOT PYTHON
    # jetbrains.phpstorm ## Universuty work
    # jetbrains.idea-ultimate ## University work
    jetbrains.datagrip ## University work
  ];
}
