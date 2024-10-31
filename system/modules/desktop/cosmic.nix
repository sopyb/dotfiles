{ config, inputs, lib, pkgs, ... }:

let
  enable = (config.specialisation != {});
in
{
  imports = [ inputs.nixos-cosmic.nixosModules.default ];

  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
  
  services = {
      displayManager.cosmic-greeter.enable = enable;
      desktopManager.cosmic.enable = enable; 
  };

  environment = {
      systemPackages = with pkgs; [
          cosmic-player
          cosmic-reader
          cosmic-ext-applet-clipboard-manager
          cosmic-ext-applet-emoji-selector
          cosmic-ext-applet-external-monitor-brightness
          cosmic-ext-examine
          cosmic-ext-tweaks
      ];

      sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1; 
  };
}
