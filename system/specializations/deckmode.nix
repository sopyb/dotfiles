{ config, lib, pkgs, ... }:

{
  specialisation = {
    deckmode = {    
      inheritParentConfig = false;
      configuration = {
        imports = [
          ../hw_cfg_victus.nix
          ../modules/common.nix
        ];
        
        config = {          
          system.nixos.tags = [ "deckmode" ];
          
          programs = {
            java.enable = true;
            gamescope = {
              enable = true;
              capSysNice = true;
            };
            steam = {
              enable = true;
              remotePlay.openFirewall = true;
              dedicatedServer.openFirewall = true;
              localNetworkGameTransfers.openFirewall = true;
              gamescopeSession.enable = true;
              
              package = pkgs.steam.override {
                extraPkgs = pkg: with pkgs; [
                  libkrb5
                  keyutils
                ];
              };
            };
          };

          hardware.nvidia = {
            # prime = {
            #   offload = {
            #     enable = lib.mkForce false;
            #     enableOffloadCmd = lib.mkForce true;
            #   };
            # 
            #   reverseSync.enable = lib.mkForce true;
            # };
            # 
            # powerManagement = {
            #   enable = lib.mkForce true;
            #   finegrained = lib.mkForce false;
            # };

            open = lib.mkForce true;
          };
          
          services.getty.autologinUser = "sopy";
          environment = {
            loginShellInit = ''
              [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
            '';
            
            systemPackages = with pkgs; [
              mangohud
              heroic-unwrapped
              steam-run
              gamescope-wsi
            ];
          };
        };
      };
    };
  };
}
