{ lib, inputs, machine, root, ... }:
let
  # Map desktop environment names to their home-manager module paths
  desktopEnvironmentHomeModules = {
    hyprland = root + /home/desktop/hyprland/hyprland.nix;
    niri = root + /home/desktop/niri/niri.nix;
  };

  waylandWindowManagers = [ "hyprland" "niri" ];

  # Import home modules for enabled desktop environments
  importDesktopEnvironmentHomes =
    lib.optionals machine.desktopEnvironment.enable
      (map (de: desktopEnvironmentHomeModules.${de})
        (lib.filter (de: desktopEnvironmentHomeModules ? ${de})
          (machine.desktopEnvironment.types or [ ])));

  # Check if any wayland window manager is enabled
  hasWaylandWM = machine.desktopEnvironment.enable &&
    lib.any (de: lib.elem de waylandWindowManagers) (machine.desktopEnvironment.types or [ ]);

  # Check machine type
  isDesktop = machine.type == "desktop" || machine.type == "hybrid";
  isServer = machine.type == "server" || machine.type == "hybrid";
in
{
  imports = [
    ./options/machine-options.nix
    (root + /home/modules/common.nix)
  ]

  # Machine type home configuration
  ++ lib.optional isDesktop (root + /home/modules/desktop.nix)
  ++ lib.optional isServer (root + /home/modules/server.nix)

  # Common wayland utilities (anyrun, swayosd, swaync)
  ++ lib.optional hasWaylandWM (root + /home/desktop/common/wayland.nix)

  # Desktop environment specific configs
  ++ importDesktopEnvironmentHomes;

  config = {
    machine = machine;
  };
}
