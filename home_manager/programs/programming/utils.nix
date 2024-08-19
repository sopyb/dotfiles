let
  addJetbrainsPlugins = ideList: 
    map (ide: 
      jetbrains.plugins.addPlugins ide [
        "github-copilot"
        "ideavim"
        "wakatime"
      ]
    ) ideList;
in
{
  inherit addJetbrainsPlugins;
}