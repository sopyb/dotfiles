{ ... }:

{
  imports = [
    ./common.nix
  ];
  
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "sopy";
  };
}