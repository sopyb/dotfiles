{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zip
    unrar
    p7zip
  ];
}
