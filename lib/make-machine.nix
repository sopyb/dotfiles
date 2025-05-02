{ lib, pkgs, inputs, system, machine, ... }:

let
  optionalModule = condition: path:
    if condition then [ path ] else [ ];
in
{
  imports = [
    ./machine-options.nix

    ../system/modules/common.nix
  ] ++
  # Machine type modules
  (optionalModule (machine.type == "desktop" || machine.type == "hybrid") ../system/modules/desktop.nix) ++
  (optionalModule (machine.type == "server" || machine.type == "hybrid") ../system/modules/server.nix) ++

  # Feature modules
  (optionalModule (machine.features.virtualization or false) ../system/modules/virtualization.nix) ++
  (optionalModule (machine.features.ollama or false) ../system/modules/ollama.nix) ++

  # Desktop Environment modules
  (optionalModule ((machine.desktopEnvironment.type or "none") == "gnome")
    ../system/modules/desktop/desktop_environments/gnome.nix) ++
  (optionalModule ((machine.desktopEnvironment.type or "none") == "hyprland")
    ../system/modules/desktop/desktop_environments/hyprland.nix) ++
  (optionalModule ((machine.desktopEnvironment.type or "none") == "cosmic")
    ../system/modules/desktop/desktop_environments/cosmic.nix) ++
  (optionalModule ((machine.desktopEnvironment.type or "none") == "plasma")
    ../system/modules/desktop/desktop_environments/plasma.nix) ++
  (optionalModule ((machine.desktopEnvironment.type or "none") == "xfce")
    ../system/modules/desktop/desktop_environments/xfce.nix) ++

  # Display Manager modules
  (optionalModule ((machine.desktopEnvironment.displayManager or "none") == "sddm")
    ../system/modules/desktop/display_managers/sddm.nix) ++
  (optionalModule ((machine.desktopEnvironment.displayManager or "none") == "ly")
    ../system/modules/desktop/display_managers/ly.nix) ++
  (optionalModule ((machine.desktopEnvironment.displayManager or "none") == "cosmic-greeter")
    ../system/modules/desktop/display_managers/cosmic-greeter.nix) ++

  # Specializations
  (optionalModule (machine.features.deckmode or false) ../system/specializations/deckmode.nix) ++
  (optionalModule (machine.features.noDGPUspecialization or false) ../system/specializations/virtualization/disableDGPUspec.nix);

  config = {
    networking.hostName = machine.name;

    machine = machine;
  };
}
