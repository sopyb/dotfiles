{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rar
    unrar
    zip
    unzip
    p7zip
  ]
}