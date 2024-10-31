{ pkgs, config, ... }:

{
  imports = [ 
#    ../../dotfiles_secrets/users/passwords.nix
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
    };
    
    users.users.sopy = {
      isNormalUser = true;
      useDefaultShell = true;
      description = "sopy";
      extraGroups = [ "networkmanager" "wheel" "dialout" "plugdev" "adbusers" "gamemode" "docker" ];
      shell = pkgs.zsh;
    };

    security.sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
}
