{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options = {
    machine = {
      name = mkOption {
        type = types.str;
        description = "Machine hostname";
        example = "myhost";
      };

      type = mkOption {
        type = types.enum [ "desktop" "server" "hybrid" ];
        default = "desktop";
        description = "The type of the machine (desktop, server, or hybrid)";
      };

      features = {
        virtualization = mkOption {
          type = types.bool;
          default = false;
          description = "Whether to enable virtualization support";
        };

        ollama = mkOption {
          type = types.bool;
          default = false;
          description = "Whether to enable Ollama AI service";
        };

        gaming = mkOption {
          type = types.bool;
          default = false;
          description = "Whether to enable gaming support";
        };

        deckmode = mkOption {
          type = types.bool;
          default = false;
          description = "Whether to enable Steam Deck mode";
        };

        noDGPUspecialization = mkOption {
          type = types.bool;
          default = false;
          description = "Whether to configure Windows VM";
        };
      };

      desktopEnvironment = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Whether to enable desktop environment";
        };

        types = mkOption {
          type = types.listOf (types.enum [ "cosmic" "gnome" "hyprland" "plasma" "xfce" ]);
          default = [ ];
          description = "List of desktop environments to install";
          example = [ "gnome" "plasma" ];
        };

        displayManager = mkOption {
          type = types.nullOr (types.enum [ "sddm" "ly" "cosmic-greeter" ]);
          default = null;
          description = "Display manager to use";
          example = "sddm";
        };
      };
    };
  };
}
