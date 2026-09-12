{ config, lib, ... }:

{
  services = {
    immich = {
      enable = true;
      host = "::";
      port = 2283;

      database = {
        enable = true;
      };

      machine-learning = {
        enable = true;
      };

      redis = {
        enable = true;
      };

      environment = {
        IMMICH_LOG_LEVEL = "warn";
      };

      mediaLocation = config.machine.variables.paths.immich
        or (throw "Machine variable paths.immich not set");
    };

    nginx.virtualHosts = lib.mkIf
      (config.machine.features.nginx
        && config.machine.variables.nginx.domain != null)
      {
        "immich.${config.machine.variables.nginx.domain}" = {
          enableACME = config.machine.variables.nginx.ssl;
          forceSSL = config.machine.variables.nginx.ssl;
          locations."/" = {
            proxyPass = "http://[::1]:${toString config.services.immich.port}";
            proxyWebsockets = true;
            recommendedProxySettings = true;
            extraConfig = ''
              client_max_body_size 50000M;
              proxy_read_timeout   600s;
              proxy_send_timeout   600s;
              send_timeout         600s;
            '';
          };
        };
      };

    # TODO: setup later
    # immich-public-proxy = {
    #   enable = true;
    # };
  };

  users.users.immich.extraGroups = [ "video" "render" ];
}
