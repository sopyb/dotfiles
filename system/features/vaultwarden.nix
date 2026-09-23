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
      environmentFile = "/var/lib/secrets/vaultwarden";
      config = {
        SIGNUPS_ALLOWED = false;
        # ADMIN_TOKEN = /var/lib/secrets/vaultwarden

        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        ROCKET_LOG = "critical";

        SSO_ENABLED = config.machine.features.authentik;
        SSO_ALLOW_UNKNOWN_EMAIL_VERIFICATION = true;
        SSO_SCOPES = "email profile offline_access";
        # SSO_AUTHORITY = /var/lib/secrets/vaultwarden
        # SSO_CLIENT_ID = /var/lib/secrets/vaultwarden
        # SSO_CLIENT_SECRET = /var/lib/secrets/vaultwarden

        SMTP_HOST = "smtp.purelymail.com";
        SMTP_PORT = 587;
        SMTP_SECURITY = "starttls";
        SMTP_FROM = "vault@sopy.one";
        SMTP_FROM_NAME = "Vaultwarden";
        SMTP_USERNAME = "vault@sopy.one";
        # SMTP_PASSWORD = /var/lib/secrets/vaultwarden

        PUSH_ENABLED = false;
        PUSH_RELAY_URI = "https://api.bitwarden.eu";
        PUSH_IDENTITY_URI = "https://identity.bitwarden.eu";
        # PUSH_INSTALLATION_ID = /var/lib/secrets/vaultwarden
        # PUSH_INSTALLATION_KEY = /var/lib/secrets/vaultwarden

        DATA_FOLDER = config.machine.variables.paths.vaultwarden;
      };
    };

    nginx.virtualHosts."${config.services.vaultwarden.domain}" = lib.mkIf config.machine.variables.nginx.ssl {
      forceSSL = true;
      enableACME = true;
    };
  };
}
