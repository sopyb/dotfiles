# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ 
      ./hardware/amdgpu.nix
      ./hardware/nvidia_mesa_nvk.nix
      ./hardware/bluetooth.nix
      ./hardware/controllers.nix
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  # boot.kernelParams = [ "amdgpu.vramlimit=2048" ]; TODO: Figure out how to give the igpu more vram
  boot.supportedFilesystems = [ "ntfs" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/39b11b9c-6cd6-4726-b3f0-013afba27e5a";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B50C-84B6";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/43980977-477a-4f43-9e87-2b6d6f9da6c9";
      fsType = "ext4";
    };

  fileSystems."/home/sopy/Windows" = {
  	device = "/dev/disk/by-uuid/9430AE4630AE2F64";
  	fsType = "ntfs-3g";
  	options = [ "rw" "uid=1000" ];
  };

  swapDevices = [ 
    {
    	device = "/dev/disk/by-uuid/dd9dd5d2-a0a9-48ed-a2d6-243608c179e8";
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
