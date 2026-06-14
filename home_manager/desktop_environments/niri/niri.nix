{ inputs, pkgs, lib, ... }:

let
  wattbar = import ../common/wattbar.nix;
in
{
  imports = [
    inputs.noctalia.homeModules.default
    wattbar.module
  ];

  home.packages = with pkgs; [
    hyprpicker
  ];

  # Noctalia shell (bar, launcher, notifications, OSD, lockscreen)
  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      wallpaper = {
        enabled = true;
        "default" = {
          path = "~/.config/niri/bg.png";
        };
      };

      lockscreen_widgets = {
        enabled = true;
      };

      shell = {
        niri_overview_type_to_launch_enabled = true;
      };
    };
  };

  # Wallpaper
  home.file.".config/niri/bg.png".source = ../common/bg.png;

  # Niri config
  xdg.configFile."niri/config.kdl".text = ''
    // https://niri-wm.github.io/niri/Configuration:-Introduction
    input {
        keyboard {
            xkb {
                layout "ro"
            }
        }

        touchpad {
            tap
            natural-scroll
            accel-profile "flat"
        }

        mouse {
            accel-profile "flat"
        }

        focus-follows-mouse
    }

    output "eDP-1" {
        mode "1920x1080@144"
        scale 1
        position x=0 y=0
    }

    output "HDMI-A-1" {
        mode "1920x1080@60"
        scale 1
        position x=0 y=1080
    }

    output "DP-2" {
        mode "1920x1080@120"
        scale 1
        position x=1920 y=0
    }

    environment {
        LIBVA_DRIVER_NAME "nvidia"
        __GLX_VENDOR_LIBRARY_NAME "nvidia"
        NVD_BACKEND "direct"
        XCURSOR_THEME "catppuccin-macchiato-lavender-cursors"
        XCURSOR_SIZE "24"
        NIXOS_OZONE_WL "1"
    }

    layout {
        gaps 8

        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        // Catppuccin Macchiato lavender / Surface0
        focus-ring {
            width 3
            active-color "#b7bdf8"
            inactive-color "#363a4f"
        }

        border {
            off
        }

        shadow {
            on
            softness 30
            spread 5
            offset x=0 y=5
            color "#0007"
        }
    }

    prefer-no-csd

    screenshot-path "~/Pictures/Screenshots/Screenshot_%Y-%m-%d_%H-%M-%S.png"

    spawn-at-startup "noctalia"
    spawn-at-startup "wattbar" "-b" "l" "--theme" "catppuccin"

    spawn-at-startup "discord"
    spawn-at-startup "zapzap"
    spawn-at-startup "signal-desktop"
    spawn-at-startup "pear-desktop"

    hotkey-overlay {
        skip-at-startup
    }

    animations {

    }

    window-rule {
        geometry-corner-radius 20
        clip-to-geometry true
    }

    window-rule {
        match app-id="dev.noctalia.Noctalia.Settings"
        open-floating true
        default-column-width { fixed 1080; }
        default-window-height { fixed 920; }
    }

    // Discord, zapzap, signal on workspace 1 (replaces Hyprland special:z)
    window-rule {
        match app-id=r#"discord|zapzap|signal-desktop|pear-desktop"#
        open-on-workspace "1"
    }

    layer-rule {
        match namespace="^noctalia-backdrop"
        place-within-backdrop true
    }

    xwayland-satellite {
        path "${lib.getExe pkgs.xwayland-satellite}"
    }

    debug {
        honor-xdg-activation-with-invalid-serial
    }

    binds {
        Mod+T { spawn "kitty"; }
        Mod+W { spawn "zen-beta"; }
        Mod+E { spawn "thunderbird"; }
        Mod+R { spawn "thunar"; }

        Mod+Space { spawn-sh "noctalia msg panel-toggle launcher"; }
        Mod+N { spawn-sh "noctalia msg panel-toggle control-center"; }    
        Mod+M { spawn-sh "noctalia msg settings-toggle"; }
        
        Mod+L { spawn "loginctl" "lock-session"; }
        Print { screenshot-screen; }
        Mod+Shift+Print { screenshot-window; }
        Mod+Shift+S { screenshot; }

        Mod+P { spawn "hyprpicker"; }

        Mod+Shift+Q repeat=false { close-window; }
        Mod+Shift+F { fullscreen-window; }
        Mod+F { maximize-column; }
        Mod+V { toggle-window-floating; }
        Mod+C { center-column; }

        // Overview
        Mod+Tab repeat=false { toggle-overview; }

        // Focus navigation
        Mod+Left  { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Up    { focus-window-up; }
        Mod+Down  { focus-window-down; }

        // Move window
        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Down  { move-window-down; }

        // Resize (replaces Hyprland resizeactive)
        Mod+Alt+Right { set-column-width "+10"; }
        Mod+Alt+Left  { set-column-width "-10"; }
        Mod+Alt+Down  { set-window-height "+10"; }
        Mod+Alt+Up    { set-window-height "-10"; }

        // Workspaces 1–9
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+0 { focus-workspace 10; }

        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }
        Mod+Shift+0 { move-column-to-workspace 10; }

        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }

        Mod+Comma  { focus-monitor-left; }
        Mod+Period { focus-monitor-right; }

        Mod+Shift+Comma  { move-column-to-monitor-left; }
        Mod+Shift+Period { move-column-to-monitor-right; }

        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }

        XF86AudioRaiseVolume  allow-when-locked=true { spawn-sh "noctalia msg volume-up"; }
        XF86AudioLowerVolume  allow-when-locked=true { spawn-sh "noctalia msg volume-down"; }
        XF86AudioMute         allow-when-locked=true { spawn-sh "noctalia msg volume-mute"; }
        XF86MonBrightnessUp   allow-when-locked=true { spawn-sh "noctalia msg brightness-up"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn-sh "noctalia msg brightness-down"; }

        XF86AudioNext  allow-when-locked=true { spawn-sh "playerctl next"; }
        XF86AudioPrev  allow-when-locked=true { spawn-sh "playerctl previous"; }
        XF86AudioPlay  allow-when-locked=true { spawn-sh "playerctl play-pause"; }
        XF86AudioPause allow-when-locked=true { spawn-sh "playerctl play-pause"; }

        Mod+Shift+M { quit; }
        Mod+Shift+P { power-off-monitors; }
        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
    }
  '';

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
