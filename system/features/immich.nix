{ config, ... }:

{
  services = {
    immich = {
      enable = true;
      host = "0.0.0.0";
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


    # TODO: setup later
    # immich-public-proxy = {
    #   enable = true;
    # };
  };

  users.users.immich.extraGroups = [ "video" "render" ];
}
