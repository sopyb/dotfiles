{ pkgs, ... }:

{
  services.xserver.enable = true; # TODO: Check if this is still needed
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty

    gnomeExtensions.blur-my-shell
    gnomeExtensions.pop-shell
    gnomeExtensions.appindicator
  ];
}
