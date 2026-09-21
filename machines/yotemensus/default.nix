{ modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.loader = {
    grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };

    timeout = 0;

    efi.canTouchEfiVariables = false;
  };

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b3c97f35-90fd-44f7-9760-f7f9dfe01fc3";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/b3c97f35-90fd-44f7-9760-f7f9dfe01fc3";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/b3c97f35-90fd-44f7-9760-f7f9dfe01fc3";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/b3c97f35-90fd-44f7-9760-f7f9dfe01fc3";
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/ACE4-63AE";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];
}