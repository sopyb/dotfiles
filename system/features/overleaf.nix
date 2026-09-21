{ config, inputs, lib, pkgs, ... }:

let
  haveDomain =
    config.machine.variables.nginx.domain != null &&
    config.machine.features.nginx;
  domain =
    if haveDomain
    then "overleaf.${config.machine.variables.nginx.domain}"
    else "localhost";
  authDomain =
    if haveDomain
    then "auth.${config.machine.variables.nginx.domain}"
    else "localhost";

  port = 8080;
  dataDir = config.machine.variables.paths.overleaf
    or (throw "Machine variable paths.overleaf not set");

  mongoInitReplicaSet = pkgs.writeText "mongodb-init-replica-set.js" ''
    rs.initiate({ _id: 'overleaf', members: [{ _id: 0, host: 'mongo:27017' }] });
  '';
in
{
  # Dreaming in a world that I can't see
  # Maybe in another life
  # I will find an inner peace
  # A place where I am free
  #
  # I wanna scream out loud
  # Nothing's what it used to be
  # There's a war inside my mind
  # But I'm not the enemy
  #
  # TODO: if I ever hate myself enough, adapt to nginx and authentik instead of making them required
  assertions = [
    {
      assertion = config.machine.features.nginx;
      message = "Overleaf requires features.nginx = true";
    }
    {
      assertion = config.machine.features.authentik;
      message = "Overleaf requires features.authentik = true";
    }
    {
      assertion = config.machine.variables.nginx.domain != null;
      message = "Overleaf requires variables.nginx.domain to be set";
    }
  ];

  imports = [
    inputs.nix-overleaf.nixosModules.default
  ];

  services.overleaf = {
    enable = true;
    host = "127.0.0.1";
    port = port;
    dataDir = dataDir;

    mongo.url = "mongodb://mongo/sharelatex";
  };

  systemd.tmpfiles.rules = [
    "d ${dataDir} 0755 overleaf overleaf -"
    "d ${dataDir}/data 0755 overleaf overleaf -"
    "d ${dataDir}/mongo_data 0755 overleaf overleaf -"
    "d ${dataDir}/redis_data 0755 overleaf overleaf -"
  ];

  # Override containers
  virtualisation.oci-containers.containers = {
    # mongo:8.0 becase Overleaf 6.x needs transactions & oplog.
    mongo = lib.mkForce {
      image = "docker.io/library/mongo:8.0";
      environment = {
        MONGO_INITDB_DATABASE = "sharelatex";
      };
      volumes = [
        "${dataDir}/mongo_data:/data/db:rw"
        "${mongoInitReplicaSet}:/docker-entrypoint-initdb.d/01-init-replica-set.js:ro"
      ];
      cmd = [ "--replSet" "overleaf" ];
      extraOptions = [
        "--add-host=mongo:127.0.0.1"
        "--network-alias=mongo"
        "--network=overleaf"
        "--expose=27017"
      ];
    };

    redis = lib.mkForce {
      serviceName = "overleaf-redis";
      image = "docker.io/library/redis:6.2";
      volumes = [ "${dataDir}/redis_data:/data:rw" ];
      cmd = [ "redis-server" "--appendonly" "yes" ];
      extraOptions = [
        "--network-alias=redis"
        "--network=overleaf"
        "--expose=6379"
      ];
    };

    sharelatex = lib.mkForce {
      image = "docker.io/overleafcep/sharelatex:6.2.0-ext-v5.0";
      ports = [ "127.0.0.1:${toString port}:80" ];
      volumes = [ "${dataDir}/data:/var/lib/overleaf" ];
      dependsOn = [ "mongo" "redis" ];
      extraOptions = [ "--network-alias=sharelatex" "--network=overleaf" ];

      environment = {
        # Overleaf
        OVERLEAF_SITE_URL = "https://${domain}";
        OVERLEAF_APP_NAME = "Overleaf";
        OVERLEAF_ADMIN_EMAIL = "contact@sopy.one";
        OVERLEAF_SITE_LANGUAGE = "en";

        TEX_LIVE_DOCKER_IMAGE = "quay.io/sharelatex/texlive-full:2026.1";
        ALL_TEX_LIVE_DOCKER_IMAGES = "quay.io/sharelatex/texlive-full:2026.1,quay.io/sharelatex/texlive-full:2025.1,quay.io/sharelatex/texlive-full:2024.1";
        ALL_TEX_LIVE_DOCKER_IMAGE_NAMES = "TeX Live 2026.1,TeX Live 2025.1,TeX Live 2024.1";

        # DB
        OVERLEAF_MONGO_URL = "mongodb://mongo/sharelatex";
        OVERLEAF_REDIS_HOST = "redis";
        OVERLEAF_REDIS_PORT = "6379";

        # Nginx Proxy
        OVERLEAF_BEHIND_PROXY = "true";
        OVERLEAF_SECURE_COOKIE = "true";
        TRUSTED_PROXY_IPS = "loopback, 10.88.0.1, 10.88.0.0/16";
        OVERLEAF_TRUSTED_PROXY_IPS = "loopback, 10.88.0.1, 10.88.0.0/16";

        # SMTP
        OVERLEAF_EMAIL_SMTP_HOST = "smtp.purelymail.com";
        OVERLEAF_EMAIL_SMTP_PORT = "587";
        OVERLEAF_EMAIL_SMTP_USER = "overleaf@sopy.one";
        # OVERLEAF_EMAIL_SMTP_PASS = /var/lib/secrets/overleaf-env

        OVERLEAF_EMAIL_SMTP_SECURE = "false";
        OVERLEAF_EMAIL_FROM_ADDRESS = "overleaf@sopy.one";
        OVERLEAF_EMAIL_REPLY_TO = "overleaf@sopy.one";

        # OIDC
        EXTERNAL_AUTH = "oidc";
        # OVERLEAF_OIDC_CLIENT_ID = /var/lib/secrets/overleaf-env
        # OVERLEAF_OIDC_CLIENT_SECRET = /var/lib/secrets/overleaf-env
        OVERLEAF_OIDC_ISSUER = "https://${authDomain}/application/o/overleaf/";
        OVERLEAF_OIDC_AUTHORIZATION_URL = "https://${authDomain}/application/o/authorize/";
        OVERLEAF_OIDC_TOKEN_URL = "https://${authDomain}/application/o/token/";
        OVERLEAF_OIDC_USER_INFO_URL = "https://${authDomain}/application/o/userinfo/";
        OVERLEAF_OIDC_LOGOUT_URL = "https://${authDomain}/application/o/overleaf/end-session/";
        OVERLEAF_OIDC_PROVIDER_NAME = "Authentik";
        OVERLEAF_OIDC_IDENTITY_SERVICE_NAME = "Authentik";
        OVERLEAF_OIDC_SCOPE = "openid email profile";
        OVERLEAF_OIDC_UPDATE_USER_DETAILS_ON_LOGIN = "true";
        OVERLEAF_OIDC_IS_ADMIN_FIELD = "username";
        OVERLEAF_OIDC_IS_ADMIN_FIELD_VALUE = "is_admin";

        # auth
        OVERLEAF_ENABLE_REGISTRATION_PAGE = "false";
        OVERLEAF_ENABLE_LOCAL_LOGIN = "false";

        # misc
        GITHUB_SYNC_ENABLED = "true";

        # GITHUB_SYNC_CLIENT_ID = /var/lib/secrets/overleaf-env
        # GITHUB_SYNC_CLIENT_SECRET = /var/lib/secrets/overleaf-env
      };

      environmentFiles = [ "/var/lib/secrets/overleaf-env" ];
    };
  };

  services.nginx.virtualHosts = lib.mkIf haveDomain {
    "${domain}" = {
      enableACME = config.machine.variables.nginx.ssl;
      forceSSL = config.machine.variables.nginx.ssl;
      locations."= /login".return = "302 /oidc/login";
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString port}";
        proxyWebsockets = true;
        recommendedProxySettings = true;
        extraConfig = ''
          client_max_body_size 50M;
          proxy_read_timeout   600s;
          proxy_send_timeout   600s;
          send_timeout         600s;
        '';
      };
    };
  };
}
