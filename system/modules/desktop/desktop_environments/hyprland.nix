{ pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  security.pam.services.hyprlock = {};

  boot.kernelParams = [
    "nvidia_drm.fbdev=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
}
