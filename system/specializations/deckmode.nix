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
          
            nixpkgs.config.allowUnfree = true;
            system.nixos.tags = [ "deckmode" ];
            
            programs = {
              java.enable = true;

              gamescope = {
                enable = true;
                capSysNice = true;
              };

              steam = {
                enable = true;

                remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
                dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
                localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
                gamescopeSession.enable = true;

                package = pkgs.steam.override {
                  extraPkgs = pkgs: with pkgs; [
                    libkrb5
                    keyutils
                    # bumblebee
                    glxinfo
                  ];
                };
              };
            };

            services.getty.autologinUser = "sopy";
            environment = {
              loginShellInit = ''
                [[ "$(tty)" = "/dev/tty1" ]] && /run/current-system/sw/bin/nvidia-offload ./gs.sh
              # [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
              '';
              
              systemPackages = with pkgs; [
                mangohud
                steam-run
                gamescope-wsi
              ];
            };
          };
        };
      };
    };
}
