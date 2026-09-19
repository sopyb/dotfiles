{ config, pkgs, ... }:


let
  domain =
    if (config.machine.variables.nginx.domain != null &&
      config.machine.features.nginx)
    then "drive.${config.machine.variables.nginx.domain}"
    else "localhost";
in
{
  services.nextcloud = {
    enable = true;
    hostName = domain;
    package = pkgs.nextcloud34;

    database.createLocally = true;

    config = {
      adminpassFile = "/var/lib/secrets/nextcloud-admin-pwd";
      dbtype = "pgsql";
    };

    settings = {
      maintenance_window_start = 1;
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
}
