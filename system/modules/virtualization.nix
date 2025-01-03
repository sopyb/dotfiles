{ pkgs, system, inputs, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };

    libvirtd.enable = true;
  };

  environment = {
    variables = {
      LIBVIRT_DEFAULT_URI = "qemu:///system";
    };

    systemPackages = with pkgs; [
      distrobox
      docker-compose
      virtiofsd
      inputs.winapps.packages.${system}.winapps
      inputs.winapps.packages.${system}.winapps-launcher
    ];
  };

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  programs.virt-manager.enable = true;
}
