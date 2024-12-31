{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rar
    zip
    p7zip
  ];
}
