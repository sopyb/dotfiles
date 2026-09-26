{ config, lib, ... }:

{
  services = {
    uptime-kuma = {
      enable = true;
      appriseSupport = true;
      settings = { };
    };

    nginx.virtualHosts = lib.mkIf
      (config.machine.features.nginx
        && config.machine.variables.nginx.domain != null)
      {
        "status.${config.machine.variables.nginx.domain}" = {
          enableACME = config.machine.variables.nginx.ssl;
          forceSSL = config.machine.variables.nginx.ssl;
          locations = {
            "/" = {
              proxyPass = "http://127.0.0.1:3001";
              proxyWebsockets = true;
              recommendedProxySettings = true;
            };
          };
        };
      };
  };
}

