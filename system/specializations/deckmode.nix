{ config, pkgs, ... }:

{ 
    specialisation = {
      deckmode = {
        configuration = {
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
            };
          };
          
          services.getty.autologinUser = "sopy";
          environment = {
            loginShellInit = ''
              [[ "$(tty)" = "/dev/tty1" ]] && ./deckmode/gs.sh
            '';

            systemPackages = with pkgs; [
              mangohud
              steam-run
            ];
          };
        };
      };
    };
}
