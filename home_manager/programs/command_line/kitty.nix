{ pkgs, ... }:

{
  # Thank you, page-down omfg
  # https://github.com/kovidgoyal/kitty/discussions/6003#discussioncomment-4947677
  home.file.".config/kitty/next_window_or_tab.py" = {
    text = builtins.readFile ./next_window_or_tab.py;
    executable = true;
  };

  programs.kitty = {
    enable = true;
    package = pkgs.kitty;

    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMonoNL NF";
      size = 10;
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+k" = "";
      "ctrl+shift+f" = "";
      "alt+equal" = "increase_font_size";
      "alt+minus" = "decrease_font_size";
      "alt+t" = "new_tab";
      "alt+[" = "launch --location=hsplit";
      "alt+]" = "launch --location=vsplit";
      "alt+left" = "kitten next_window_or_tab.py left";
      "alt+right" = "kitten next_window_or_tab.py right";
      "alt+up" = "neighboring_window up";
      "alt+down" = "neighboring_window down";
      "alt+shift+up" = "move_window up";
      "alt+shift+down" = "move_window down";
      "alt+shift+left" = "move_window left";
      "alt+shift+right" = "move_window right";
      "alt+ctrl+left" = "resize_window narrower";
      "alt+ctrl+right" = "resize_window wider";
      "alt+ctrl+up" = "resize_window shorter";
      "alt+ctrl+down" = "resize_window taller";
      "alt+q" = "close_window";
    };

    settings = {
      "background_opacity_inactive_transparent" = 0.5;
      "background_opacity" = 0.7;
      "scrollback_lines" = 10000;
      "enable_audio_bell" = false;
      "update_check_interval" = 0;
      "allow_remote_control" = "yes";
      "enabled_layouts" = "splits";
      "window_border_width" = "1pt";
    };


    themeFile = "Catppuccin-Macchiato";
  };

}
