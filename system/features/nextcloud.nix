# Thank https://diogotc.com/blog/collabora-nextcloud-nixos/ for helping me setup CODE
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
  codeDomain =
    if
      (config.machine.variables.nginx.domain != null &&
        config.machine.features.nginx)
    then
      "office.${config.machine.variables.nginx.domain}"
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

      phpOptions = {
        "opcache.interned_strings_buffer" = "16";
      };

      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps)
          user_oidc calendar contacts dav_push groupfolders
          notes tasks deck forms polls guests quota_warning
          richdocuments;
      };

      extraAppsEnable = true;
    };


    collabora-online = {
      enable = true;

      settings = {
        ssl = {
          enable = false;
          termination = true;
        };

        net = {
          listen = "loopback";
          post_allow.host = [ "::1" ];
        };

        storage.wopi = {
          "@allow" = true;
          host = [ domain ];
        };

        server_name = codeDomain;
      };
    };

    nginx.virtualHosts = {
      "${domain}" = lib.mkIf config.machine.variables.nginx.ssl {
        forceSSL = true;
        enableACME = true;
      };


      "${codeDomain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://[::1]:${toString config.services.collabora-online.port}";
          proxyWebsockets = true; # collabora uses websockets
        };
      };
    };
  };

  systemd.services.nextcloud-config-collabora =
    let
      inherit (config.services.nextcloud) occ;

      wopi_url = "http://[::1]:${toString config.services.collabora-online.port}";
      public_wopi_url = "https://${codeDomain}";
      wopi_allowlist = lib.concatStringsSep "," [
        "127.0.0.1"
        "::1"
      ];
    in
    {
      wantedBy = [ "multi-user.target" ];
      after = [ "nextcloud-setup.service" "coolwsd.service" ];
      requires = [ "coolwsd.service" ];
      script = ''
        ${occ}/bin/nextcloud-occ config:app:set richdocuments wopi_url --value ${lib.escapeShellArg wopi_url}
        ${occ}/bin/nextcloud-occ config:app:set richdocuments public_wopi_url --value ${lib.escapeShellArg public_wopi_url}
        ${occ}/bin/nextcloud-occ config:app:set richdocuments wopi_allowlist --value ${lib.escapeShellArg wopi_allowlist}
        ${occ}/bin/nextcloud-occ richdocuments:setup
      '';
      serviceConfig = {
        Type = "oneshot";
      };
    };

  systemd.services.nextcloud-setup.unitConfig.RequiresMountsFor =
    config.machine.variables.paths.nextcloud;
  systemd.services.phpfpm-nextcloud.unitConfig.RequiresMountsFor =
    config.machine.variables.paths.nextcloud;


  networking.hosts = {
    "127.0.0.1" = [ domain codeDomain ];
    "::1" = [ domain codeDomain ];
  };
}
