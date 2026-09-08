{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    modesetting.enable = lib.mkDefault true;
    powerManagement = {
      enable = lib.mkDefault true;
      finegrained = lib.mkDefault false;
    };
    open = lib.mkDefault false;
    nvidiaSettings = lib.mkDefault true;
    package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.latest;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
}
