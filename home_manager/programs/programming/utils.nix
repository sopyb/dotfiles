{ inputs, pkgs, ... }:

let
  inherit (inputs.nix-jetbrains-plugins.lib) buildIdeWithPlugins;

  addJetbrainsPlugins = ideList:
    map
      (ide:
        buildIdeWithPlugins pkgs ide [
          "com.github.copilot"
          "IdeaVIM"
        ]
      )
      ideList;
in
{
  inherit addJetbrainsPlugins;
}
