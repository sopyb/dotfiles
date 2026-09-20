{ config, pkgs, lib, ... }:


let
  domain =
    if
      (config.machine.variables.nginx.domain != null &&
        config.machine.features.nginx)
    then
      "drive.${config.machine.variables.nginx.domain}"
    else
      "localhost";
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
          richdocuments;
      };

      extraAppsEnable = true;
    };

    nginx.virtualHosts."${domain}" = lib.mkIf config.machine.variables.nginx.ssl {
      forceSSL = true;
      enableACME = true;
    };
  };

  systemd.services.nextcloud-setup.unitConfig.RequiresMountsFor =
    config.machine.variables.paths.nextcloud;
  systemd.services.phpfpm-nextcloud.unitConfig.RequiresMountsFor =
    config.machine.variables.paths.nextcloud;
}
