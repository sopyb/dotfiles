{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      corefonts

      nerdfonts
      noto-fonts-color-emoji
      
      monocraft # nixpkgs version includes the nerd-fonts patched version the NUR one doesn't
    ];

    enableDefaultPackages = true;

    fontconfig = {

        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
        };
    };
  };
}