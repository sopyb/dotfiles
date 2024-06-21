{ pkgs, ... }:

{
  imports = [ 
    ../../dotfiles_secrets/users/passwords.nix
  ];

  options.sopy.users = { };

  config = {
    programs = {
      zsh = {
        enable = true;

        enableCompletion = true;
        autosuggestions.enable = true;
    
        enableGlobalCompInit = false;
        syntaxHighlighting.enable = true;
      };

      direnv.enable = true;

      htop = {
        enable = true;
        settings.show_cpu_temperature = 1;
      };
    };
    
    users.users.sopy = {
      isNormalUser = true;
      useDefaultShell = true;
      description = "sopy";
      extraGroups = [ "networkmanager" "wheel" "dialout" "plugdev" "adbusers" ];
      shell = pkgs.zsh;
    };

    security.sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
    system.stateVersion = "23.09"; # Did you read the comment?
  };
}
