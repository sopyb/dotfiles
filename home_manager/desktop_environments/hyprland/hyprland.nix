{ pkgs, ... }:

{
  home.packages = with pkgs; [
    activate-linux
    anyrun
    brightnessctl
    hyprpicker
    hyprpolkitagent
    hyprshot
    swaynotificationcenter

    wev # for debugging
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct"

        "XCURSOR_SIZE,16"
        "HYPRCURSOR_SIZE,16"
      ];

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        "activate-linux"
        "swaync"
        "swayosd-server"
        "systemctl --user start hyprpaper"
        "systemctl --user start hyprpolkitagent"

        # autostart apps and move to workspace 1
        "[workspace special:z silent] discord"
        "[workspace special:x silent] zapzap"
        "[workspace special:c silent] spotify"
      ];

      monitor = [
        "eDP-1,    1920x1080@144,     0x1440, 1"
        "HDMI-A-1, 1920x1080@119.88,  0x0,    1, mirror, eDP-1"
        "DP-2,     2560x1440@59.95,   0x0,    1"
      ];

      "$mod" = "SUPER";
      "$term" = "kitty";
      "$mail" = "thunderbird";
      "$fileManager" = "thunar";
      "$browser" = "floorp";

      animations = {
        enabled = false;
      };

      input = {
        kb_layout = "ro";

        sensitivity = 1;
        follow_mouse = 1;
        accel_profile = "flat";


        touchpad = {
          natural_scroll = true;
        };

      };

      device = [
        {
          name = "logitech-pro-x-wireless";
          sensitivity = -0.8;
        }
                {
                  name = "logitech-pro-x-wireless-1";
                  sensitivity = -0.8;
                }
                        {
                          name = "logitech-pro-x-wireless-2";
                          sensitivity = -0.8;
                        }
      ];
      gestures = {
        workspace_swipe = true;
        workspace_swipe_min_fingers = true;
        workspace_swipe_cancel_ratio = 0.3;
      };

      misc = {
        disable_hyprland_logo = true;
      };

      bindel = [
        "    ,XF86AudioRaiseVolume,  exec, swayosd-client --output-volume raise --max-volume 175"
        "    ,XF86AudioLowerVolume,  exec, swayosd-client --output-volume lower --max-volume 175"
        "    ,XF86AudioMute,         exec, swayosd-client --output-volume mute-toggle"
        "    ,XF86AudioMicMute,      exec, swayosd-client --input-volume mute-toggle"
        "    ,XF86MonBrightnessUp,   exec, swayosd-client --brightness +10"
        "    ,XF86MonBrightnessDown, exec, swayosd-client --brightness -10"
      ];

      bindl = [
        "    , XF86AudioNext,  exec, playerctl next"
        "    , XF86AudioPause, exec, playerctl play-pause"
        "    , XF86AudioPlay,  exec, playerctl play-pause"
        "    , XF86AudioPrev,  exec, playerctl previous"
      ];

      bindr = [
        "$mod, SUPER_L,     exec, anyrun"
        "CAPS, Caps_Lock,   exec, swayosd-client --caps-lock"   # Caps Lock
        "MOD2, code:77,     exec, swayosd-client --num-lock"    # Num Lock
        "    , Scroll_Lock, exec, swayosd-client --scroll-lock" # Scroll Lock
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        # Apps
        "$mod, w, exec, $browser"
        "$mod, e, exec, $mail"
        "$mod, r, exec, $fileManager"
        "$mod, t, exec, $term"

        # Screenshots
        "          , print, exec, hyprshot -m output --clipboard-only --freeze"
        "$mod SHIFT, print, exec, hyprshot -m window --clipboard-only --freeze"
        "$mod SHIFT, s,     exec, hyprshot -m region --clipboard-only --freeze"

        # Color picker
        "$mod, p, exec, hyprpicker"

        # Notifications
        "$mod, n, exec, swaync-client -t"

        # Window stuff  
        "$mod SHIFT, q, killactive"
        "$mod SHIFT, f, fullscreen"
        "$mod, v, togglefloating"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

      ] ++ (builtins.concatLists (builtins.genList
        (i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9)) ++ [
        "$mod, z, togglespecialworkspace, z"
        "$mod SHIFT, z, movetoworkspace, special:z"
        "$mod, x, togglespecialworkspace, x"
        "$mod SHIFT, x, movetoworkspace, special:x"
        "$mod, c, togglespecialworkspace, c"
        "$mod SHIFT, c, movetoworkspace, special:c"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        "$mod CONTROL, left, workspace, e-1"
        "$mod CONTROL, right, workspace, e+1"

        "$mod, comma, focusmonitor, -1"
        "$mod, period, focusmonitor, +1"

        "$mod SHIFT, comma, movewindow, mon:-1"
        "$mod SHIFT, period, movewindow, mon:+1"

        # Compositor
        "$mod SHIFT, m, exit"
      ];

      windowrule = [
        "workspace special:z silent, class:discord"
      ];

      "$PiP" = "class:^(floorp)$, title:^(Firefox|Picture-in-Picture)$";

      windowrulev2 = [
         "float, $PiP"
        "pin, $PiP"
        "move 78% 40%, $PiP"
        "size 20% 20%, $PiP"
      ];
    };
  };

  home.file.".config/hypr/bg.png".source = ../common/bg.png;

  services = {
    hyprpaper = {
      enable = true;

      settings = {
        ipc = true;
        splash = true;
        splash_offset = 2.0;

        preload = [ "~/.config/hypr/bg.png" ];

        wallpaper = [
          "eDP-1,    ~/.config/hypr/bg.png"
          "HDMI-A-1, ~/.config/hypr/bg.png"
          "DP-2,     ~/.config/hypr/bg.png"
        ];
      };
    };

    swayosd = {
        enable = true;
    };
  };

  programs = {
    hyprlock = {
        enable = true;

        settings = {
          general = {
            disable_loading_bar = true;
            grace = 300;
            hide_cursor = true;
            no_fade_in = false;
          };
        
          background = [
            {
              path = "~/.config/hypr/bg.png";
              blur_passes = 3;
              blur_size = 8;
            }
          ];
        
          input-field = [
            {
              size = "200, 50";
              position = "0, -80";
              monitor = "";
              dots_center = true;
              fade_on_empty = false;
              font_color = "rgb(202, 211, 245)";
              inner_color = "rgb(91, 96, 120)";
              outer_color = "rgb(24, 25, 38)";
              outline_thickness = 5;
              placeholder_text = ''<span foreground="#cad3f5">Password...</span>'';
              shadow_passes = 2;
            }
          ];
        };
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}

