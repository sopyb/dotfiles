{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji

      fira-code
      fira-code-symbols

      corefonts

      monocraft
    ] ++ builtins.filter (x: lib.isDerivation x) (builtins.attrValues pkgs.nerd-fonts);

    enableDefaultPackages = true;

    fontconfig = {

      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
