{ inputs, ...}:

{
    imports = [ minesddm.nixosModules.default ];

    services.xserver.displayManager.sddm = {
      enable = true;
      theme = "minesddm";
   };
}
