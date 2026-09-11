{ lib, ... }:

let
  inherit (lib) mkOption mkEnableOption types;
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
        type = types.enum [ "desktop" "server" "hybrid" "minimal" ];
        default = "desktop";
        description = "The type of the machine (desktop, server, hybrid, or minimal)";
      };

      desktopEnvironment = {
        enable = mkEnableOption "Whether to enable desktop environment";

        types = mkOption {
          type = types.listOf (types.enum [ "cosmic" "gnome" "hyprland" "niri" "plasma" "xfce" ]);
          default = [ ];
          description = "List of desktop environments to install";
          example = [ "gnome" "plasma" ];
        };

        displayManager = mkOption {
          type = types.nullOr (types.enum [ "sddm" "ly" "cosmic-greeter" "noctalia-greeter" ]);
          default = null;
          description = "Display manager to use";
          example = "sddm";
        };
      };

      features = {
        immich = mkEnableOption "Whether to enable immich service";
        nginx = mkEnableOption "Whether to enable the nginx service";
        ollama = mkEnableOption "Whether to enable Ollama AI service";
        sshd = mkEnableOption "Whether to enable sshd";
        sunshine = mkEnableOption "Whether to enable sunshine";
        virtualDisplay = mkEnableOption "Whether to add a virtual display";
        virtualization = mkEnableOption "Whether to enable virtualization support";
      };

      specializations = {
        deckmode = mkEnableOption "Whether to enable Steam Deck mode";
        noDedicatedGPU = mkEnableOption "Specialization with the dGPU setup for passthrough";
      };

      tweaks = {
        autoLogin = mkEnableOption "Whether to login automatically on the machine";
        noFirewall = mkEnableOption "Whether to disable the firewall on the machine";
        noSleep = mkEnableOption "Whether to disable sleep on the machine";
      };

      variables = {
        dGpuPciId = mkOption {
          type = types.nullOr types.str;
          default = null;
          example = "0000:01:00.0";
          description = "PCI bus ID of the dedicated GPU to unbind in this specialisation";
        };

        gitSigningKey = mkOption {
          type = types.str;
          default = "";
          description = "GPG key ID for git commit signing";
        };

        gitSigning = mkEnableOption "Whether to sign git commits by default";

        nginx = {
          domain = mkOption {
            type = types.nullOr types.str;
            default = null;
            example = "example.com";
            description = "TLD to use for services";
          };

          ssl = mkEnableOption "Whether to issue ssl certs for the domains";
        };

        paths = {
          immich = mkOption {
            type = types.nullOr types.str;
            default = null;
            example = "/mnt";
            description = "PCI bus ID of the dedicated GPU to unbind in this specialisation";
          };
        };
      };
    };
  };
}
