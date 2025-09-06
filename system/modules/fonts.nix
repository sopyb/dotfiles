{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-color-emoji

      fira-code
      fira-code-symbols

      corefonts


      monocraft # nixpkgs version includes the nerd-fonts patched version the NUR one doesn't
    ] ++ builtins.filter (x: lib.isDerivation x) (builtins.attrValues pkgs.nerd-fonts);

    enableDefaultPackages = true;

    fontconfig = {

      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
