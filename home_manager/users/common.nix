{ pkgs, ... }:

{
  imports = [ 
    ../../dotfiles_secrets/user/passwords.nix
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


      direnv = {
        enable = true;
        package = pkgs.direnv;
        silent = false;
        loadInNixShell = true;
        direnvrcExtra = "";
        nix-direnv = {
          enable = true;
          package = pkgs.nix-direnv;
        };
      };


      htop = {
        enable = true;
        settings.show_cpu_temperature = 1;
      };
    }
    
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

  };
}
