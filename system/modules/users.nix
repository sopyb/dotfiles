{ pkgs, ... }:

{
  imports = [
    #    ../../dotfiles_secrets/users/passwords.nix
  ];

  options.sopy.users = { };

  config = {
    programs = {
      zsh = {
        enable = true;
      };

      direnv.enable = true;
    };

    users.users.sopy = {
      isNormalUser = true;
      useDefaultShell = true;
      description = "sopy";
      extraGroups = [ "networkmanager" "wheel" "dialout" "plugdev" "adbusers" "gamemode" "video" "docker" "kvm" "libvirtd" "input" ];
      shell = pkgs.zsh;
    };

    security.sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
}
