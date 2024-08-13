{ inputs, ... }:

{
  imports = [ inputs.nixos-cosmic.nixosModules.default ];

  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
  
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
}