{ pkgs, inputs, ... }:

{
  imports = [ inputs.niri.nixosModules.niri ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  boot.kernelParams = [
    "nvidia_drm.fbdev=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = [ "gnome" ];
      };
      niri = {
        default = [ "gnome" ];
        # "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        # "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      };
    };
  };
}
