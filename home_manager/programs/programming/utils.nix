{ pkgs, ... }:

let
  addJetbrainsPlugins = ideList:
    map
      (ide:
        pkgs.jetbrains.plugins.addPlugins ide [
          # "github-copilot"
          # "ideavim"
        ]
      )
      ideList;
in
{
  inherit addJetbrainsPlugins;
}
