{ config, lib, ... }:

{
  config = {
    security.acme = lib.mkIf config.machine.variables.nginx.ssl
      (
        let
          tld = config.machine.variables.nginx.domain or (throw "nginx.domain must be set to use ssl");
        in
        {
          acceptTerms = true;
          defaults.email = "contact@sopy.one";
          certs."${tld}" = {
            domain = "*.${tld}";
            group = "nginx";

            dnsProvider = "inwx";
            environmentFile = "/var/lib/secrets/inwx-secrets";
            extraLegoFlags = [
              "--dns.resolvers=1.1.1.1:53,8.8.8.8:53"
            ];
          };
        }
      );

    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = lib.mkIf config.machine.variables.nginx.ssl true;

      defaultListenAddresses = [ "0.0.0.0" "[::]" ];

      virtualHosts."_" = {
        default = true;
        rejectSSL = config.machine.variables.nginx.ssl;
        locations."/".return = "444";
      };
    };
  };
}
