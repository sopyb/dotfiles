{ ... }:

{
  imports = [
    ./common.nix

    ../programs/communication
    ../programs/media
    ../programs/misc
    ../programs/programming
  ];

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "always";
  };
}
  
