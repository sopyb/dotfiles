{ pkgs, ... }:

{
  imports = [
    #    ../../dotfiles_secrets/users/passwords.nix
  ];

  options.sopy.users = { };

  config = {
    programs = {
      fish = {
        enable = true;
      };

      direnv.enable = true;
    };

    users.users.sopy = {
      isNormalUser = true;
      useDefaultShell = true;
      description = "sopy";
      extraGroups = [ "networkmanager" "wheel" "dialout" "plugdev" "adbusers" "gamemode" "docker" "kvm" "libvirtd" "input" ];
      shell = pkgs.fish;
    };

    security.sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
}
