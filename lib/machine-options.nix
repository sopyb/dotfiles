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

        type = mkOption {
          type = types.enum [ "gnome" "hyprland" "cosmic" "plasma" "xfce" "none" ];
          default = "none";
          description = "Desktop environment to use";
        };

        displayManager = mkOption {
          type = types.enum [ "sddm" "ly" "cosmic-greeter" "none" ];
          default = "none";
          description = "Display manager to use";
        };
      };
    };
  };
}
