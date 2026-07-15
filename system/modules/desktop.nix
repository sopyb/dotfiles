{ pkgs, self, ... }:

{
  imports = [
    ./common.nix
    ./features/boot.nix
    ./features/fonts.nix
    ./features/programs.nix
    ./features/services.nix
    (self + /system/desktop/limits.nix)

    # Program hooks
    ./features/gamemode.nix
  ];

  environment.systemPackages = with pkgs; [
    libnotify
  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.dotnet_8.sdk}/share/dotnet";
  };
}
