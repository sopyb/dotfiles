{ lib, inputs, machine, self, ... }:
let
  # Map desktop environment names to their home-manager module paths
  desktopEnvironmentHomeModules = {
    hyprland = self + /home/desktop/hyprland/hyprland.nix;
    niri = self + /home/desktop/niri/niri.nix;
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
    (self + /home/modules/common.nix)
  ]

  # Machine type home configuration
  ++ lib.optional isDesktop (self + /home/modules/desktop.nix)
  ++ lib.optional isServer (self + /home/modules/server.nix)

  # Common wayland utilities (anyrun, swayosd, swaync)
  ++ lib.optional hasWaylandWM (self + /home/desktop/common/wayland.nix)

  # Desktop environment specific configs
  ++ importDesktopEnvironmentHomes;

  config = {
    machine = machine;
  };
}
