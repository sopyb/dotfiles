{ config, pkgs, lib, ... }:


let
  haveDomain =
    (config.machine.variables.nginx.domain != null &&
      config.machine.features.nginx);
  domain =
    if haveDomain
    then "drive.${config.machine.variables.nginx.domain}"
    else "localhost";
  officeDomain =
    if haveDomain
    then "office.${config.machine.variables.nginx.domain}"
    else "localhost";
in
{
  services = {
    nextcloud = {
      enable = true;
      https = true;
      hostName = domain;
      package = pkgs.nextcloud34;

      datadir = config.machine.variables.paths.nextcloud;

      database.createLocally = true;

      config = {
        adminpassFile = "/var/lib/secrets/nextcloud-admin-pwd";
        dbtype = "pgsql";
      };

      settings = {
        allow_local_remote_servers = true;
        maintenance_window_start = 4;
        default_phone_region = "RO";
        log_type = "systemd";
        serverid = 0;
      };

      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps)
          user_oidc calendar contacts dav_push groupfolders
          notes tasks deck forms polls guests quota_warning
          onlyoffice;
      };

      extraAppsEnable = true;
    };

    onlyoffice = {
      enable = true;
      hostname = officeDomain;
      jwtSecretFile = "/var/lib/secrets/onlyoffice-jwt";
      securityNonceFile = "/var/lib/secrets/onlyoffice-nonce";
    };

    nginx.virtualHosts = lib.mkIf config.machine.variables.nginx.ssl {
      "${domain}" = {
        forceSSL = true;
        enableACME = true;
      };
      "${officeDomain}" = {
        forceSSL = true;
        enableACME = true;
      };
    };
  };

  systemd.services.nextcloud-setup.unitConfig.RequiresMountsFor =
    config.machine.variables.paths.nextcloud;
  systemd.services.phpfpm-nextcloud.unitConfig.RequiresMountsFor =
    config.machine.variables.paths.nextcloud;

  systemd.services.nextcloud-onlyoffice-config = {
    description = "Configure the Nextcloud ONLYOFFICE connector";
    after = [ "nextcloud-setup.service" ];
    requires = [ "nextcloud-setup.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      occ=${config.services.nextcloud.occ}/bin/nextcloud-occ
      $occ config:app:set onlyoffice DocumentServerUrl --value="https://${officeDomain}/"
      $occ config:app:set onlyoffice jwt_secret --value="$(cat /var/lib/secrets/onlyoffice-jwt)"
    '';
  };
}
