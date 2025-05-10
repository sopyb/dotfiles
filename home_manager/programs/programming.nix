{ pkgs, inputs, ... }:

let
  utils = import ./programming/utils.nix { inherit pkgs; };
in
{
  imports = [
    ./programming/vscode.nix
  ];


  home.packages = with pkgs; [
    arduino-ide
    matlab
    vscode
    android-studio

    # DES
    uppaal

    # Java6 :c Java 8 eh
    jdk8
    # staruml

    # Rust toolchain
    rustup

    # II stuff
    dotnetCorePackages.dotnet_8.sdk
    dotnetCorePackages.dotnet_8.aspnetcore
  ] ++ utils.addJetbrainsPlugins [
    # android-studio
    # jetbrains.clion ## llvm & university work
    jetbrains.webstorm ## random web projects - Portfolio time
    # jetbrains.rust-rover ## sheesh
    # jetbrains.pycharm-professional ## not python... NOT PYTHON
    # jetbrains.phpstorm ## Universuty work
    jetbrains.idea-ultimate ## University work
    jetbrains.datagrip ## University work
    jetbrains.goland
    jetbrains.rider
  ];
}
