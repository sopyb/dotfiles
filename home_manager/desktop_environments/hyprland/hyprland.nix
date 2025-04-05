{ pkgs, ... }:

{
  home.packages = with pkgs; [
    anyrun
    hyprpolkitagent
    swaynotificationcenter
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
        "swaync"
        "systemctl --user start hyprpolkitagent"
        "hyprpaper"

        # autostart apps and move to workspace 1
        "[workspace special:z silent] discord"
        "[workspace special:x silent] zapzap"
        "[workspace special:c silent] spotify"
      ];

      monitor = [
        "eDP-1, 1920x1080@144, 0x0, 1"
        "HDMI-A-1, 1920x1080@75, 0x0, 1"
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
          name = "logitech-pro-x-wireless-2";
          sensitivity = -0.8;
        }
        {
          name = "logitech-pro-x-wireless-1";
          sensitivity = -0.8;
        }
      ];
      gestures = {
        workspace_swipe = true;
        workspace_swipe_min_fingers = true;
        workspace_swipe_cancel_ratio = 0.3;
      };

      bindr = [
        "$mod, SUPER_L, exec, anyrun"
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
        # Window stuff  
        "$mod SHIFT, q, killactive"
        "$mod SHIFT, m, exit"

        "$mod, v, togglefloating"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

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

        "$mod CONTROL, left, workspace, e-1"
        "$mod CONTROL, right, workspace, e+1"

        "$mod, comma, focusmonitor, -1"
        "$mod, period, focusmonitor, +1"

        "$mod SHIFT, comma, movewindow, mon:-1"
        "$mod SHIFT, period, movewindow, mon:+1"
      ];

      windowrule = [
        "workspace special:z silent, class:discord"
      ];
    };
  };

  home.file.".config/hypr/bg.png".source = ../common/bg.png;

  services = {
    hyprpaper = {
      enable = true;

      settings = {
        ipc = "off";
        splash = true;
        splash_offset = 2.0;

        preload = [ "~/.config/hypr/bg.png" ];

        wallpaper = [
          "eDP-1,~/.config/hypr/bg.png"
          "HDMI-A-1,~/.config/hypr/bg.png"
        ];
      };
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}

