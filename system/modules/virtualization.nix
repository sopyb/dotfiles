{ pkgs, system, inputs, ... }:

{
  virtualisation = {
    libvirtd.enable = true;
  };

  environment = {
    variables = {
      LIBVIRT_DEFAULT_URI = "qemu:///system";
    };

    systemPackages = with pkgs; [
      virtiofsd
    ];
  };

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  programs.virt-manager.enable = true;
}
