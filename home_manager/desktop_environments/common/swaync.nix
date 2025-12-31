{
  cmd = {
    daemon = "swaync";
    toggle = "swaync-client -t";
  };

  module = { pkgs, lib, ... }: {
    services.swaync = lib.mkDefault {
        enable = true;
    };
  };
}
