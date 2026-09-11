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

            dnsProvider = "cloudflare";
            environmentFile = "/var/lib/secrets/cloudflare";
          };
        }
      );

    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = lib.mkIf config.machine.variables.nginx.ssl true;
    };
  };
}
