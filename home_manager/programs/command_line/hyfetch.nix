{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fastfetch
  ];

  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "transgender";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.5;
      color_align = {
        mode = "horizontal";
        custom_colors = [];
        fore_back = null;
      };
      backend = "fastfetch";
      args = null;
      distro = null;
      pride_month_shown = [];
      pride_month_disable = true;
    };
  };
}
