{ pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;

      qemu.verbatimConfig = ''
        cgroup_device_acl = [
          "/dev/null", "/dev/full", "/dev/zero",
          "/dev/random", "/dev/urandom",
          "/dev/ptmx", "/dev/kvm",
          "/dev/userfaultfd",
          "/dev/kvmfr0"
        ]
      '';
    };

  };

  environment = {
    variables = {
      LIBVIRT_DEFAULT_URI = "qemu:///system";
    };

    systemPackages = with pkgs; [
      virtiofsd
      looking-glass-client
    ];
  };

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  programs.virt-manager.enable = true;
}
