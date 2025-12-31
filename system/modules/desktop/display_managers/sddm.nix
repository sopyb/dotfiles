{ inputs, ... }:

{
  imports = [ inputs.minesddm.nixosModules.default ];

  services.displayManager = {

    sddm = {
      enable = true;
      theme = "minesddm";
    };
  };
}
