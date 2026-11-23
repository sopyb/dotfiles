{ ... }:

{
  programs.fastfetch = {
    enable = true;

    settings.modules = [
      {
        type = "title";
        color = {
          user = "red";
          at = "white";
          host = "red";
        };
      }
      {
        type = "os";
        key = "󱄅";
        keyColor = "cyan";
      }
      {
        type = "kernel";
        key = "";
        keyColor = "yellow";
      }
      {
        type = "uptime";
        key = "";
        keyColor = "green";
      }
      {
        type = "packages";
        key = "";
        keyColor = "blue";
      }
      {
        type = "shell";
        key = "";
        keyColor = "magenta";
      }
      {
        type = "wm";
        key = "";
        keyColor = "red";
      }
      {
        type = "theme";
        key = "";
        keyColor = "cyan";
      }
      {
        type = "icons";
        key = "";
        keyColor = "yellow";
      }
      {
        type = "font";
        key = "";
        keyColor = "green";
      }
      {
        type = "cursor";
        key = "";
        keyColor = "blue";
      }
      {
        type = "terminal";
        key = "";
        keyColor = "magenta";
      }
      {
        type = "terminalfont";
        key = "";
        keyColor = "red";
      }
      {
        type = "cpu";
        key = "";
        keyColor = "cyan";
      }
      {
        type = "gpu";
        key = "";
        keyColor = "yellow";
      }
      {
        type = "memory";
        key = "";
        keyColor = "green";
      }
      {
        type = "swap";
        key = "";
        keyColor = "blue";
      }
      {
        type = "disk";
        key = "";
        keyColor = "magenta";
      }
      "break"
      "colors"
    ];
  };

  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "transgender";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.25;
      color_align = {
        mode = "custom";
        custom_colors = {
          "1" = 0;
          "2" = 1;
          "3" = 2;
          "4" = 0;
          "5" = 1;
          "6" = 2;

        };
        fore_back = null;
      };
      backend = "fastfetch";
      args = null;
      distro = "nixos_colorful";
      pride_month_shown = [ ];
      pride_month_disable = true;
    };
  };
}
