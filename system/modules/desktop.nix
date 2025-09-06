{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ./boot.nix
    ./fonts.nix
    ./programs.nix
    ./services.nix
    ./desktop/limits.nix
  ];

  environment.systemPackages = with pkgs; [
    libnotify
  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.dotnet_8.sdk}/share/dotnet";
  };
}
