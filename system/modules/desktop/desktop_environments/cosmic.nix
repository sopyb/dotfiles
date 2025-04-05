{ inputs, pkgs, ... }:

{
  imports = [ inputs.nixos-cosmic.nixosModules.default ];

  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

  services.desktopManager.cosmic.enable = true;

  environment = {
    systemPackages = with pkgs; [
      cosmic-player
      cosmic-reader
      cosmic-ext-applet-clipboard-manager
      cosmic-ext-applet-emoji-selector
      cosmic-ext-applet-external-monitor-brightness
      examine
      cosmic-ext-tweaks
    ];

    sessionVariables = {
      COSMIC_DATA_CONTROL_ENABLED = 1;
      COSMIC_DISABLE_DIRECT_SCANOUT = 1;
    };
  };
}
