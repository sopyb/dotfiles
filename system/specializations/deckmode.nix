specialisation = {
  deckmode.configuration = {
    services.xserver.desktopManager.plasma5.enable = true;
  };

  sopy = {
    inheritParentConfig = true;
    configuration = {
      import = [
        # ../modules/users.nix
      ]
    
      system.nixos.tags = [ "deckmode" ];

      programs = {
        gamescope = {
          enable = true;
          capSysNice = true;
        };
        steam = {
          enable = true;
          package = pkgs.steam.override {
            withPrimus = true;
            withJava = true;
            extraPkgs = pkgs: [ bumblebee glxinfo ];
          };
          gamescopeSession.enable = true;
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
