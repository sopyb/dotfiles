{ self, ... }:

{
  imports = [
    (self + /home/programs/base)

    (self + /home/programs/communication)
    (self + /home/programs/media)
    (self + /home/programs/misc)
    (self + /home/programs/programming)
  ];

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "always";
  };
}
  
