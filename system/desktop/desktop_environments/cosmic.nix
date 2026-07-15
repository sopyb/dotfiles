{ pkgs, ... }:

{
  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

  services.desktopManager.cosmic.enable = true;

  environment = {
    systemPackages = with pkgs; [
      cosmic-player
      cosmic-reader
      cosmic-applets
      examine
      cosmic-ext-ctl
      cosmic-ext-calculator
      cosmic-ext-tweaks
    ];

    sessionVariables = {
      COSMIC_DATA_CONTROL_ENABLED = 1;
      # COSMIC_DISABLE_DIRECT_SCANOUT = 1;
    };
  };
}
