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
  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.dotnet_8.sdk}/share/dotnet";
  };
}
