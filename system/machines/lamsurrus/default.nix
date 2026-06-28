{ lib, ... }:

{
  imports = [
    ../../modules/boot.nix
  ];

  virtualisation.vmVariant = {
    virtualisation = {
      diskSize = 32 * 1024;
      memorySize = 16 * 1024;
      cores = 8;
    };
  };

  # disable pipewire and pulseaudio so no audio can be played from the vm
  services.pipewire.enable = lib.mkForce false;
}