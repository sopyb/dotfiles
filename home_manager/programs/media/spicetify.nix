{ pkgs, lib, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify =
    {
      enable = true;
      theme = spicePkgs.themes.starryNight;
      colorScheme = "default";

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
      ];
    };
}