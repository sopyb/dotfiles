{ config, lib, pkgs, ... }:

{
imports = [
          inputs.vgpu4nixos.nixosModules.host
];

hardware.nvidia.vgpu.patcher.enable = true;
hardware.nvidia.vgpu.griddUnlock.enable = true;
hardware.nvidia.vgpu.patcher.profileOverrides = {
  "gming" = {
    vramAllocation = 3072; # 3GiB
    heads = 1;
    display.width = 1920;
    display.height = 1080;
    framerateLimit = 144;
  };
};
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    nvidiaSettings = lib.mkDefault true;
    package = config.boot.kernelPackages.nvidiaPackages.vgpu_18_1;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
}
