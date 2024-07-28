{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerdfonts
    
    monocraft # nixpkgs version includes the nerd-fonts patched version the NUR one doesn't
  ];

  fonts.fontconfig.enable = true;
}