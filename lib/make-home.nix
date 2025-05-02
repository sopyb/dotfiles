{ lib, pkgs, inputs, system, machine, machineName, ... }:

# This module sets up home-manager configuration based on machine options
let
  # Helper function to conditionally import a module
  optionalModule = condition: path:
    if condition then [ path ] else [ ];
  machineVars = (import ../home_manager/utils/machineVariables.nix { inherit lib; }).getMachineVariables machineName;
in
{
  imports = [
    ./machine-options.nix
    ../home_manager/modules/common.nix
  ]
  # Machine type home configuration
  ++ (optionalModule (machine.type == "desktop" || machine.type == "hybrid") ../home_manager/modules/desktop.nix)
  ++ (optionalModule (machine.type == "server" || machine.type == "hybrid") ../home_manager/modules/server.nix)

  # Desktop Environment specific configs
  ++ (optionalModule (machine.desktopEnvironment.enable && machine.desktopEnvironment.type == "hyprland")
    ../home_manager/desktop_environments/hyprland/hyprland.nix);

  options.machineVariables = lib.mkOption {
    type = lib.types.attrs;
    default = { };
    description = "Machine-specific variables for home configuration";
  };

  # Set machine configuration
  config = {
    machine = machine;
    machineVariables = machineVars;
  };
}
