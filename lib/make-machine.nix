{ lib, machine, root, inputs, home-manager, ... }:
let
  optional = condition: path:
    lib.optional condition path;

  # Map desktop environment names to their module paths
  desktopEnvironmentModules = {
    cosmic = root + /system/modules/desktop/desktop_environments/cosmic.nix;
    gnome = root + /system/modules/desktop/desktop_environments/gnome.nix;
    hyprland = root + /system/modules/desktop/desktop_environments/hyprland.nix;
    niri = root + /system/modules/desktop/desktop_environments/niri.nix;
    plasma = root + /system/modules/desktop/desktop_environments/plasma.nix;
    xfce = root + /system/modules/desktop/desktop_environments/xfce.nix;
  };

  # Map display manager names to their module paths
  displayManagerModules = {
    sddm = root + /system/modules/desktop/display_managers/sddm.nix;
    ly = root + /system/modules/desktop/display_managers/ly.nix;
    cosmic-greeter = root + /system/modules/desktop/display_managers/cosmic-greeter.nix;
    noctalia-greeter = root + /system/modules/desktop/display_managers/noctalia-greeter.nix;
  };

  # Import desktop environments from the list
  importDesktopEnvironments =
    map (de: desktopEnvironmentModules.${de})
      (machine.desktopEnvironment.types or [ ]);

  # Import display manager if specified
  importDisplayManager =
    let dm = machine.desktopEnvironment.displayManager or null;
    in optional (dm != null && displayManagerModules ? ${dm}) displayManagerModules.${dm};

  # Check machine type
  isDesktop = machine.type == "desktop" || machine.type == "hybrid";
  isServer = machine.type == "server" || machine.type == "hybrid";
  isMinimal = machine.type == "minimal";
in
{
  imports = [
    ./options/machine-options.nix

    (root + /system/modules/common.nix)
  ]
  # Machine type modules
  ++ optional isDesktop (root + /system/modules/desktop.nix)
  ++ optional isServer (root + /system/modules/server.nix)
  ++ optional isMinimal (root + /system/modules/minimal.nix)
  # Feature modules
  ++ optional (machine.features.virtualization or false) (root + /system/modules/virtualization.nix)
  ++ optional (machine.features.ollama or false) (root + /system/modules/ollama.nix)

  # Desktop environments and display manager
  ++ importDesktopEnvironments
  ++ importDisplayManager

  # Specializations
  ++ optional (machine.features.deckmode or false) (root + /system/specializations/deckmode.nix)
  ++ optional (machine.features.noDGPUspecialization or false) (root + /system/specializations/virtualization/disableDGPUspec.nix)

  # Home Manager
  ++ [ home-manager.nixosModules.home-manager ];

  config = {
    networking.hostName = machine.name;

    machine = machine;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs root;
        machine = machine;
      };
      backupFileExtension = "old";

      users.sopy = {
        imports = [ (root + /lib/make-home.nix) ];
      };
    };
  };
}
