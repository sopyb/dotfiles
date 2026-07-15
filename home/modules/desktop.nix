{ self, ... }:

{
  imports = [
    (self + /home/modules/common.nix)

    (self + /home/modules/programs/communication)
    (self + /home/modules/programs/media)
    (self + /home/modules/programs/misc)
    (self + /home/modules/programs/programming)
  ];

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "always";
  };
}
  
