{ pkgs, ... }:

let
  addJetbrainsPlugins = ideList: 
    map (ide: 
      pkgs.jetbrains.plugins.addPlugins ide [
        "github-copilot-intellij"
        "ideavim"
      ] 
    ) ideList;
in
{
  inherit addJetbrainsPlugins;
}
