{ pkgs, system, inputs, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      distrobox
      docker-compose
    ];
  };
}
