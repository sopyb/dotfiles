{ pkgs, inputs, system, ... }:

let
  grub-theme = inputs.distro-grub-themes.packages.${system}.nixos-grub-theme;
in
{
  imports = [ inputs.minegrub-world-sel-theme.nixosModules.default ];

  config = {
    boot = {
      loader = rec {
        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          useOSProber = true;

          minegrub-world-sel = {
            enable = true;
            customIcons = [{
              name = "nixos";
              lineTop = "NixOS (23/11/2023, 23:03)";
              lineBottom = "Survival Mode, No Cheats, Version: 23.11";
              # Icon: you can use an icon from the remote repo, or load from a local file
              imgName = "nixos";
              # customImg = builtins.path {
              #   path = ./nixos-logo.png;
              #   name = "nixos-img";
              # };
            }];
          };

          extraEntries = ''
            menuentry "Nobara Linux" {
              search --no-floppy --fs-uuid --set=root 7D6D-06E4
              chainloader /EFI/fedora/shimx64.efi
            }
          '';
        };

        efi.canTouchEfiVariables = true;
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

    system.stateVersion = "24.05";
  };
}
