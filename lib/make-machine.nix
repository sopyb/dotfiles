{ lib, machine, self, inputs, home-manager, ... }:
let
  optional = condition: path:
    lib.optional condition path;

  # Map desktop environment names to their module paths
  desktopEnvironmentModules = {
    cosmic = self + /system/desktop/desktop_environments/cosmic.nix;
    gnome = self + /system/desktop/desktop_environments/gnome.nix;
    hyprland = self + /system/desktop/desktop_environments/hyprland.nix;
    niri = self + /system/desktop/desktop_environments/niri.nix;
    plasma = self + /system/desktop/desktop_environments/plasma.nix;
    xfce = self + /system/desktop/desktop_environments/xfce.nix;
  };

  # Map display manager names to their module paths
  displayManagerModules = {
    sddm = self + /system/desktop/display_managers/sddm.nix;
    ly = self + /system/desktop/display_managers/ly.nix;
    cosmic-greeter = self + /system/desktop/display_managers/cosmic-greeter.nix;
    noctalia-greeter = self + /system/desktop/display_managers/noctalia-greeter.nix;
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

    (self + /system/modules/common.nix)
  ]
  # Machine type modules
  ++ optional isDesktop (self + /system/modules/desktop.nix)
  ++ optional isServer (self + /system/modules/server.nix)
  ++ optional isMinimal (self + /system/modules/minimal.nix)
  # Feature modules
  ++ optional (machine.features.virtualization or false) (self + /system/modules/features/virtualization.nix)
  ++ optional (machine.features.ollama or false) (self + /system/modules/features/ollama.nix)

  # Desktop environments and display manager
  ++ importDesktopEnvironments
  ++ importDisplayManager

  # Specializations
  ++ optional (machine.features.deckmode or false) (self + /system/specializations/deckmode.nix)
  ++ optional (machine.features.noDGPUspecialization or false) (self + /system/specializations/virtualization/disableDGPUspec.nix)

  # Home Manager
  ++ [ home-manager.nixosModules.home-manager ];

  config = {
    networking.hostName = machine.name;

    machine = machine;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs self machine;
      };
      backupFileExtension = "old.bak";

      users.sopy = {
        imports = [ (self + /lib/make-home.nix) ];
      };
    };
  };
}
