{
  cmd = {
    daemon = "swaync";
    toggle = "swaync-client -t";
  };

  module = { pkgs, ... }: {
    home.packages = with pkgs; [
      swaynotificationcenter
    ];
  };
}
