{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ./desktop/limits.nix
  ];

  environment.systemPackages = with pkgs; [
    libnotify
    nvtopPackages.nvidia
    nvtopPackages.amd
    nvtopPackages.intel
    cloudflared
  ];


  environment.etc."ssh/ssh_config".text = ''
    Host *.sopy.one
      ProxyCommand ${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h
  '';
}