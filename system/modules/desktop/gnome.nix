{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty

    gnomeExtensions.blur-my-shell
    gnomeExtensions.pop-shell
    gnomeExtensions.appindicator
  ];
}
