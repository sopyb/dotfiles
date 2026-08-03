{ inputs, pkgs, ... }:

let
  utils = import ./utils.nix { inherit inputs pkgs; };
in
{
  imports = [
    ./vscode.nix
  ];


  home.packages = with pkgs; [
    # arduino-ide
    # nur.repos.xddxdd.mtkclient

    # python stuff TwT
    # poetry

    # Rust toolchain
    rustup
  ] ++ utils.addJetbrainsPlugins [
    # android-studio
    jetbrains.clion ## llvm & university work
    # jetbrains.webstorm ## random web projects - Portfolio time
    # jetbrains.rust-rover ## sheesh
    # jetbrains.pycharm ## not python... NOT PYTHON
    # jetbrains.phpstorm ## Universuty work
    # jetbrains.idea ## University work
    # jetbrains.datagrip ## University work
    # jetbrains.goland
    jetbrains.rider ## I guess we are doing Avicii invector mods now
  ];
}
