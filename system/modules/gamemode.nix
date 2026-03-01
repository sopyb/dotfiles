{ lib, config, pkgs, ... }:
{
  options.programs.gamemodeCommands = {
    start = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    end = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config.programs.gamemode.settings.custom = {
    start = lib.optionalString (config.programs.gamemodeCommands.start != [])
      (toString (pkgs.writeShellScript "gamemode-start" ''
        ${lib.concatStringsSep "\n" config.programs.gamemodeCommands.start}
      ''));
    end = lib.optionalString (config.programs.gamemodeCommands.end != [])
      (toString (pkgs.writeShellScript "gamemode-end" ''
        ${lib.concatStringsSep "\n" config.programs.gamemodeCommands.end}
      ''));
  };
}
