{ pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./fonts.nix
    ./limits.nix
    ./nix_settings.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    ./virtualization.nix
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  time.timeZone = "EET";

  environment.systemPackages = with pkgs; [
    libnotify
    nvtopPackages.nvidia
    nvtopPackages.amd
    nvtopPackages.intel
    cloudflared  
    openrgb-with-all-plugins 
  ];

  
  environment.etc."ssh/ssh_config".text = ''
    Host *.sopy.one
      ProxyCommand ${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h
  '';
}
