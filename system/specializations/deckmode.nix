{ pkgs, ... }:

{
  specialisation = {
    deckmode = {
      inheritParentConfig = false;
      configuration = {
        imports = [
          ../hw_cfg_alphicta.nix
          ../modules/common.nix
        ];

        config = {
          system.nixos.tags = [ "deckmode" ];

          boot.loader.grub.configurationName = ''Deck Mode" --class "deckmode'';

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

          services.getty.autologinUser = "sopy";
          services.switcherooControl.enable = true;
          environment = {
            loginShellInit = ''
              [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
            '';

            systemPackages = with pkgs; [
              mangohud
              heroic
              steam-run
              gamescope-wsi

              bluetuith
            ];
          };
        };
      };
    };
  };
}
