{ ... }:

{
  imports = [
    ./common.nix

    ../programs/communication.nix
    ../programs/media.nix
    ../programs/misc.nix
    ../programs/programming.nix
  ];

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "always";
  };
}
  
