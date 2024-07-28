{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerdfonts
      noto-fonts-color-emoji
      
      monocraft # nixpkgs version includes the nerd-fonts patched version the NUR one doesn't
    ];

    fontconfig = {
        enable = true;

        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
        };
    };
  };
}