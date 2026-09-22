{ modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.loader = {
    grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };

    timeout = 0;

    efi.canTouchEfiVariables = false;
  };

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/b3c97f35-90fd-44f7-9760-f7f9dfe01fc3";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/b3c97f35-90fd-44f7-9760-f7f9dfe01fc3";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/b3c97f35-90fd-44f7-9760-f7f9dfe01fc3";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  fileSystems."/var/log" =
    {
      device = "/dev/disk/by-uuid/b3c97f35-90fd-44f7-9760-f7f9dfe01fc3";
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/ACE4-63AE";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  networking = {
    useDHCP = false;

    interfaces.ens3 = {
      ipv4.addresses = [
        {
          address = "5.45.96.148";
          prefixLength = 24;
        }
      ];

      ipv6.addresses = [
        {
          address = "2a03:4000:5:5d0:2426:82ff:fef1:167b";
          prefixLength = 64;
        }
      ];
    };

    # Upstream Gateways
    defaultGateway = {
      address = "5.45.96.1";
      interface = "ens3";
    };

    defaultGateway6 = {
      address = "fe80::1";
      interface = "ens3";
    };

    wireguard.interfaces.wg0 = {
      ips = [ "10.10.0.1/24" "fd10:10::1/64" ];
      listenPort = 51820;
      privateKeyFile = "/var/lib/secrets/wireguard/private";
      peers = [
        {
          publicKey = "4MFXeezRngzom8mtrFSVFNYA24t1jhtq97FXeCK1jW0=";
          allowedIPs = [ "10.10.0.2/32" "fd10:10::2/128" ];
        }
      ];
    };

    firewall = {
      enable = true;
      allowPing = true;
      checkReversePath = "loose";

      allowedTCPPortRanges = [
        { from = 1; to = 65535; }
      ];
      allowedUDPPortRanges = [
        { from = 1; to = 65535; }
      ];

      extraCommands = ''
        iptables -t nat -I PREROUTING 1 -i ens3 -p tcp -m tcp -m conntrack --ctstate NEW ! --dport 22 -j DNAT --to-destination 10.10.0.2
        iptables -t nat -I PREROUTING 2 -i ens3 -p udp -m udp -m conntrack --ctstate NEW ! --dport 51820 -j DNAT --to-destination 10.10.0.2
        iptables -I FORWARD 1 -d 10.10.0.2 -j ACCEPT
        iptables -I FORWARD 2 -s 10.10.0.2 -j ACCEPT

        ip6tables -t nat -I PREROUTING 1 -i ens3 -p tcp -m tcp -m conntrack --ctstate NEW ! --dport 22 -j DNAT --to-destination fd10:10::2
        ip6tables -t nat -I PREROUTING 2 -i ens3 -p udp -m udp -m conntrack --ctstate NEW ! --dport 51820 -j DNAT --to-destination fd10:10::2
        ip6tables -I FORWARD 1 -d fd10:10::2 -j ACCEPT
        ip6tables -I FORWARD 2 -s fd10:10::2 -j ACCEPT
      '';

      extraStopCommands = ''
        iptables -t nat -F PREROUTING || true
        iptables -D FORWARD -d 10.10.0.2 -j ACCEPT || true
        iptables -D FORWARD -s 10.10.0.2 -j ACCEPT || true

        ip6tables -t nat -F PREROUTING || true
        ip6tables -D FORWARD -d fd10:10::2 -j ACCEPT || true
        ip6tables -D FORWARD -s fd10:10::2 -j ACCEPT || true
      '';
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
    "net.ipv6.conf.ens3.accept_ra" = 2;
  };

  services.qemuGuest.enable = true;

  swapDevices = [ ];
}
