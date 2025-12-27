{ lib, inputs, machine, machineName, ... }:
let
  machineVars = (import ../home_manager/utils/machineVariables.nix { inherit lib; }).getMachineVariables machineName;

  # Map desktop environment names to their home-manager module paths
  desktopEnvironmentHomeModules = {
    hyprland = ../home_manager/desktop_environments/hyprland/hyprland.nix;
  };

  # Import home modules for enabled desktop environments
  importDesktopEnvironmentHomes =
    lib.optionals machine.desktopEnvironment.enable
      (map (de: desktopEnvironmentHomeModules.${de})
        (lib.filter (de: desktopEnvironmentHomeModules ? ${de})
          (machine.desktopEnvironment.types or [ ])));

  # Check machine type
  isDesktop = machine.type == "desktop" || machine.type == "hybrid";
  isServer = machine.type == "server" || machine.type == "hybrid";
in
{
  imports = [
    ./machine-options.nix
    ./home-manager-options.nix
    ../home_manager/modules/common.nix
    inputs.zen-browser.homeModules.beta
  ]

  # Machine type home configuration
  ++ lib.optional isDesktop ../home_manager/modules/desktop.nix
  ++ lib.optional isServer ../home_manager/modules/server.nix

  # Desktop environment specific configs
  ++ importDesktopEnvironmentHomes;

  config = {
    machine = machine;
    machineVariables = machineVars;
  };
}
