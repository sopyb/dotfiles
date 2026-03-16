{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  security.pam.services.hyprlock = { };

  boot.kernelParams = [
    "nvidia_drm.fbdev=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # TODO: move this to a separate file
  environment.systemPackages = [ pkgs.swayosd ];
  services.udev.packages = [ pkgs.swayosd ];

  systemd.services.swayosd-libinput-backend = {
    description = "SwayOSD LibInput backend for listening to certain keys like CapsLock, ScrollLock, VolumeUp, etc.";
    documentation = [ "https://github.com/ErikReider/SwayOSD" ];
    wantedBy = [ "graphical.target" ];
    partOf = [ "graphical.target" ];
    after = [ "graphical.target" ];

    serviceConfig = {
      Type = "dbus";
      BusName = "org.erikreider.swayosd";
      ExecStart = "${pkgs.swayosd}/bin/swayosd-libinput-backend";
      Restart = "on-failure";
    };
  };
}
