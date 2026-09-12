{ config, inputs, ... }:

{
  assertions = [
    {
      assertion = config.machine.features.nginx;
      message = "Authentik requires features.nginx = true";
    }
    {
      assertion = config.machine.variables.nginx.domain != null;
      message = "Authentik requires variables.nginx.domain to be set";
    }
  ];

  imports = [
    inputs.authentik-nix.nixosModules.default
  ];

  services = {
    authentik = {
      enable = true;

      environmentFile = "/var/lib/secrets/authentik";

      settings = {
        email = {
          host = "smtp.purelymail.com";
          port = 587;
          username = "auth@sopy.one";
          use_tls = true;
          use_ssl = false;
          from = "auth@sopy.one";
        };

        storage = {
          backend = "file";
          file.path = config.machine.variables.paths.authentik
            or (throw "Machine variable paths.authentik not set");
        };

        avatars = "gravatar";
        disable_startup_analytics = true;
      };
    };


    nginx.virtualHosts = {
      "auth.${config.machine.variables.nginx.domain}" = {
        enableACME = config.machine.variables.nginx.ssl;
        forceSSL = config.machine.variables.nginx.ssl;
        locations."/" = {
          proxyPass = "http://127.0.0.1:9000";
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
  };
}
