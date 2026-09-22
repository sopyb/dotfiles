{ config, pkgs, lib, ... }:

{
  assertions = [
    {
      assertion = config.machine.features.nginx;
      message = "Vaultwarden requires features.nginx = true";
    }
    {
      assertion = config.machine.variables.nginx.domain != null;
      message = "Vaultwarden requires variables.nginx.domain to be set";
    }
  ];

  services = {
    vaultwarden = {
      enable = true;

      package = pkgs.vaultwarden-postgresql;
      dbBackend = "postgresql";

      configureNginx = true;
      configurePostgres = true;
      domain = "vault.${config.machine.variables.nginx.domain}";
      # backupDir = config.machine.variables.paths.vaultwarden;
      environmentFile = "/var/lib/secrets/vaultwarden";
      config = {
        SIGNUPS_ALLOWED = false;

        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        ROCKET_LOG = "critical";

        SSO_ENABLED = config.machine.features.authentik;
        SSO_ONLY = config.machine.features.authentik;
        SSO_ALLOW_UNKNOWN_EMAIL_VERIFICATION = true;
        SSO_SCOPES = "email profile";

        SMTP_HOST = "smtp.purelymail.com";
        SMTP_PORT = 587;
        SMTP_SECURITY = "starttls";
        SMTP_FROM = "vault@sopy.one";
        SMTP_FROM_NAME = "Vaultwarden";
        SMTP_USERNAME = "vault@sopy.one";
      };
    };


    nginx.virtualHosts."${config.services.vaultwarden.domain}" = lib.mkIf config.machine.variables.nginx.ssl {
      forceSSL = true;
      enableACME = true;
    };
  };
}
