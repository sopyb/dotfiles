{ pkgs, inputs, ... }:

{
  imports = [ inputs.minesddm.nixosModules.default ];

  services.displayManager = {
  
          sessionPackages = [ pkgs.niri ];
      sddm = {
        enable = true;
        theme = "minesddm";
        };
    };
}
