{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    inputs.vgpu4nixos.nixosModules.host
  ];


  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_6;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    nvidiaSettings = lib.mkDefault true;
    package = config.boot.kernelPackages.nvidiaPackages.vgpu_17_3;

    vgpu.patcher = {
      enable = true;
      profileOverrides = {
        "gming" = {
          vramAllocation = 3072; # 3GiB
          heads = 1;
          display.width = 1920;
          display.height = 1080;
          framerateLimit = 144;
        };
      };
    };
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
}
