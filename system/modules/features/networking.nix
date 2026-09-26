{ ... }:

{
  networking = {
    enableIPv6 = true;

    extraHosts = builtins.concatStringsSep "\n" [
      "192.168.1.133 alphicta.sopy.one"
      "192.168.1.135 zetalyeh.sopy.one"

      "130.61.169.33 omegantes.sopy.one"
      "  5.45.96.148 yotemen.sopy.one"
    ];

    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };
}
