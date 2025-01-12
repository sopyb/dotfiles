{ lib, pkgs, inputs, ... }:

{
  imports = [ inputs.minegrub-world-sel-theme.nixosModules.default ];

  config = {
    boot = {
      loader = {
        grub = {
          enable = true;
          device = lib.mkDefault "nodev";
          efiSupport = lib.mkDefault true;
          useOSProber = lib.mkDefault true;
          gfxmodeEfi = lib.mkDefault "1920x1080";

          minegrub-world-sel = {
            enable = true;
            customIcons = [
              {
                name = "nixos";
                lineTop = "NixOS";
                lineBottom = lib.concatStrings [ "Spectator Mode, Cheats, Version: " (lib.versions.majorMinor lib.version) ];
                imgName = "nixos";
              }
            ];
          };

          extraEntries = ''
            menuentry "Nobara Linux" --class nobara --class gnu-linux --class gnu --class os {
              search --no-floppy --fs-uuid --set=root 7D6D-06E4
              chainloader /EFI/fedora/shimx64.efi
            }

            menuentry "UEFI Settings" --class uefi --class firmware {
              fwsetup
            }
          '';
        };

        efi.canTouchEfiVariables = lib.mkDefault true;
      };

      kernelPackages = pkgs.linuxPackages_latest;

      plymouth = {
        enable = true;
        themePackages = with pkgs; [
          plymouth-blahaj-theme
        ];
        theme = "blahaj";
      };


      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"

        "plymouth:delay=5"
      ];
    };

    environment.systemPackages = with pkgs; [
      os-prober
    ];


    system.stateVersion = "24.05";
  };
}
