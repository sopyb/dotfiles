{ lib, machine, ... }:
let
  optional = condition: path:
    lib.optional condition path;

  # Map desktop environment names to their module paths
  desktopEnvironmentModules = {
    cosmic = ../system/modules/desktop/desktop_environments/cosmic.nix;
    gnome = ../system/modules/desktop/desktop_environments/gnome.nix;
    hyprland = ../system/modules/desktop/desktop_environments/hyprland.nix;
    niri = ../system/modules/desktop/desktop_environments/niri.nix;
    plasma = ../system/modules/desktop/desktop_environments/plasma.nix;
    xfce = ../system/modules/desktop/desktop_environments/xfce.nix;
  };

  # Map display manager names to their module paths
  displayManagerModules = {
    sddm = ../system/modules/desktop/display_managers/sddm.nix;
    ly = ../system/modules/desktop/display_managers/ly.nix;
    cosmic-greeter = ../system/modules/desktop/display_managers/cosmic-greeter.nix;
  };

  # Import desktop environments from the list
  importDesktopEnvironments =
    map (de: desktopEnvironmentModules.${de})
      (machine.desktopEnvironment.types or [ ]);

  # Import display manager if specified
  importDisplayManager =
    let dm = machine.desktopEnvironment.displayManager;
    in optional (dm != null && displayManagerModules ? ${dm}) displayManagerModules.${dm};

  # Check machine type
  isDesktop = machine.type == "desktop" || machine.type == "hybrid";
  isServer = machine.type == "server" || machine.type == "hybrid";
in
{
  imports = [
    ./machine-options.nix

    ../system/modules/common.nix
  ]
  # Machine type modules
  ++ optional isDesktop ../system/modules/desktop.nix
  ++ optional isServer ../system/modules/server.nix

  # Feature modules
  ++ optional (machine.features.virtualization or false) ../system/modules/virtualization.nix
  ++ optional (machine.features.ollama or false) ../system/modules/ollama.nix

  # Desktop environments and display manager
  ++ importDesktopEnvironments
  ++ importDisplayManager

  # Specializations
  ++ optional (machine.features.deckmode or false) ../system/specializations/deckmode.nix
  ++ optional (machine.features.noDGPUspecialization or false) ../system/specializations/virtualization/disableDGPUspec.nix;

  config = {
    networking.hostName = machine.name;

    machine = machine;
  };
}
