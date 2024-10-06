{ config, inputs, lib, ... }:

let
  enable = (config.specialisation != {});
in
{
  imports = [ inputs.nixos-cosmic.nixosModules.default ];

  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
  
  services.displayManager.cosmic-greeter.enable = enable;
  services.desktopManager.cosmic.enable = enable;  
}
