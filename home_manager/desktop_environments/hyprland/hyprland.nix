{ pkgs, ... }:

let
  anyrun = import ../common/anyrun.nix;
  swayosd = import ../common/swayosd.nix;
  swaync = import ../common/swaync.nix;
  wattbar = import ../common/wattbar.nix;
in
{
  home.packages = with pkgs; [
    # cosmic-launcher
    hyprpicker
    hyprpolkitagent
    hyprshot
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = with pkgs.hyprlandPlugins; [
      # hyprsplit
      hyprexpo
    ];

    settings = {
      plugin = {
        split-monitor-workspaces = {
          count = 10;
          enable_notifications = 1;
        };

        hyprexpo = {
          columns = 3;
          gap_size = 5;
          bg_col = "rgb(111111)";
          workspace_method = "center current";
          gesture_distance = 300;
        };
      };

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "NVD_BACKEND,direct"

        "XCURSOR_THEME,catppuccin-macchiato-lavender-cursors"
        "XCURSOR_SIZE,24"

        "HYPRCURSOR_THEME,catppuccin-macchiato-lavender-cursors"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        layout = "scrolling";
      };

      cursor = {
        "no_hardware_cursors" = true;
      };

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hyprpm reload -n"

        wattbar.cmd.start
        swaync.cmd.daemon
        swayosd.cmd.server
        "systemctl --user start hyprpaper"
        "systemctl --user start hyprpolkitagent"
        # "hypridle"

        # autostart apps and move to workspace 1
        "[workspace special:z silent] discord"
        "[workspace special:x silent] zapzap"
        "[workspace special:c silent] youtube-music"
      ];

      monitor = [
        "eDP-1,    1920x1080@144,     0x0, 1"
        "HDMI-A-1, 1920x1080@60,  0x0, 1, mirror, eDP-1"
        "DP-2,     1920x1080@120,   1920x0,    1"
      ];

      "$mod" = "SUPER";
      "$term" = "kitty";
      "$mail" = "thunderbird";
      "$fileManager" = "thunar";
      "$browser" = "zen";

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

      bezier = [
        "easeInOutCustom, 0.20, 0.00, 0.20, 1"
      ];

      animation = [
        "global, 1, 2, easeInOutCustom"
        "workspaces, 1, 2, easeInOutCustom, slidevert"
      ];

      gesture = [
        "3, vertical, workspace"
      ];

      hyprexpo-gesture = [
        "4, vertical, expo"
      ];

      misc = {
        disable_hyprland_logo = true;
      };

      debug = {
        full_cm_proto = true;
      };

      bindel = [
        "    ,XF86AudioRaiseVolume,  exec, ${swayosd.cmd.volumeUp}"
        "    ,XF86AudioLowerVolume,  exec, ${swayosd.cmd.volumeDown}"
        "    ,XF86AudioMute,         exec, ${swayosd.cmd.volumeMute}"
        "    ,XF86AudioMicMute,      exec, ${swayosd.cmd.micMute}"
        "    ,XF86MonBrightnessUp,   exec, ${swayosd.cmd.brightnessUp}"
        "    ,XF86MonBrightnessDown, exec, ${swayosd.cmd.brightnessDown}"
      ];

      bindl = [
        "    , XF86AudioNext,  exec, playerctl next"
        "    , XF86AudioPause, exec, playerctl play-pause"
        "    , XF86AudioPlay,  exec, playerctl play-pause"
        "    , XF86AudioPrev,  exec, playerctl previous"
      ];

      bindr = [
        "$mod, SUPER_L,     exec, ${anyrun.cmd.toggle}"
        "CAPS, Caps_Lock,   exec, ${swayosd.cmd.capsLock}"
        "MOD2, code:77,     exec, ${swayosd.cmd.numLock}"
        "    , Scroll_Lock, exec, ${swayosd.cmd.scrollLock}"
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

        # Resize
        "$mod ALT, right, resizeactive, 10 0"
        "$mod ALT, left,  resizeactive, -10 0"
        "$mod ALT, up,    resizeactive, 0 -10"
        "$mod ALT, down,  resizeactive, 0 10"

        # Overview
        "$mod, tab, hyprexpo:expo, toggle"

        # Lock
        "$mod, l, exec, hyprlock"

        # Screenshots
        "          , print, exec, hyprshot -m output --clipboard-only --freeze"
        "$mod SHIFT, print, exec, hyprshot -m window --clipboard-only --freeze"
        "$mod SHIFT, s,     exec, hyprshot -m region --clipboard-only --freeze"

        # Color picker
        "$mod, p, exec, hyprpicker"

        # Notifications
        "$mod, n, exec, ${swaync.cmd.toggle}"

        # Window stuff
        "$mod SHIFT, q, killactive"
        "$mod SHIFT, f, fullscreen, 1"
        "$mod, v, togglefloating"

        "$mod ALT, right, workspace, e+1"
        "$mod ALT, left,  workspace, e-1"
        # "$mod ALT, right, split:workspace, e+1"
        # "$mod ALT, left,  split:workspace, e-1"

      ] ++ (builtins.concatLists (builtins.genList
        (i:
          let
            ws = i + 1;
          in
          [
            # "$mod, code:1${toString i}, split:workspace, ${toString ws}"
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            # "$mod SHIFT, code:1${toString i}, split:movetoworkspace, ${toString ws}"
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
        "match:class discord, workspace special:z silent"
        "match:class deadlocked, no_blur on"
        "match:class deadlocked, opaque on"
      ];

      # "$PiP" = "class:^(floorp)$, title:^(Firefox|Picture-in-Picture)$"; TODO: do this with window rules for zen-browser pip

      # windowrulev2 = [
      #   "float, $PiP"
      #   "pin, $PiP"
      #   "move 78% 40%, $PiP"
      #   "size 20% 20%, $PiP"
      # ];
    };
  };

  home.file.".config/hypr/bg.png".source = ../common/bg.png;

  services = {
    hyprpaper = {
      enable = true;

      settings = {
        ipc = true;
        splash = true;
        splash_offset = 10;

        preload = [ "~/.config/hypr/bg.png" ];

        wallpaper = builtins.map
          (monitor:
            {
              inherit monitor;
              path = "~/.config/hypr/bg.png";
              fit_mode = "cover";
            }
          ) [ "eDP-1" "HDMI-A-1" "DP-2" ];
      };
    };

    hypridle = {
      enable = true;

      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
          before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
          after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };

  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        grace = 2;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "~/.config/hypr/bg.png";
          blur_passes = 3;
          blur_size = 3;
        }
      ];

      # Username label
      label = [
        {
          monitor = "";
          text = "Hi there, $USER";
          text_align = "center";
          color = "rgb(202, 211, 245)"; # Catppuccin Machiatto Text
          font_size = 24;
          font_family = "JetBrains Mono Nerd Font";
          position = "0, -40";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "$TIME";
          text_align = "center";
          color = "rgb(183, 189, 248)"; # Catppuccin Machiatto lavender
          font_size = 128;
          font_family = "JetBrains Mono Nerd Font";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          size = "300, 60";
          position = "0, -100";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)"; # Catppuccin Machiatto Text
          inner_color = "rgba(54, 58, 79, 0.8)"; # Catppuccin Machiatto Surface0 with transparency
          outer_color = "rgb(183, 189, 248)"; # Catppuccin Machiatto lavender
          outline_thickness = 3;
          placeholder_text = ''Password...'';
          shadow_passes = 2;
          dots_spacing = 0.3;
          dots_rounding = -1;
          rounding = 10;
        }
      ];
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
