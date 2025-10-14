{ pkgs, config, ... }:

let
  catppuccin-micro = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "micro";
    rev = "015a2bb208f61a2d5a33121de2644bf4a059436b";
    sha256 = "sha256-XbhUwRz21/XLkdOb6VOqLwzxWtehf6qRms0YcepNQ0s=";
  };
in
{
  programs.micro = {
    enable = true;

    settings = {
      autosu = true;
      colorscheme = "catppuccin-macchiato";
      mkparents = true;
      tabstospaces = true;
      truecolor = true;
    };
  };

  home.file."${config.xdg.configHome}/micro/colorschemes" = {
    source = "${catppuccin-micro}/themes";
    recursive = true;
  };
}
