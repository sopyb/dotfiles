{ pkgs, lib, ... }:

{
  imports = [
    ../../modules/boot.nix
    ../../modules/server/services.nix
  ];

  environment.systemPackages = with pkgs; [
    custom.mpv
    custom.ytcui

    yt-dlp
  ];

  virtualisation.vmVariant = {
    virtualisation = {
      qemu = {
        enableSharedMemory = true;


        options = [
          ''-display gtk,gl=on''
          ''-device virtio-vga-gl''
        ];
      };

      forwardPorts = [
        { from = "host"; host.port = 2222; guest.port = 22; }
        { from = "host"; host.port = 3389; guest.port = 3389; }
      ];

      diskSize = 32 * 1024;
      memorySize = 16 * 1024;
      cores = 8;
    };

    networking.firewall.enable = false;
  };

  # disable pipewire and pulseaudio so no audio can be played from the vm
  services.pipewire.enable = lib.mkForce false;

  # enable screen sharing for the vm
  services.gnome.gnome-remote-desktop.enable = true;
  systemd.services.gnome-remote-desktop = {
    wantedBy = [ "graphical.target" ];
  };
}
