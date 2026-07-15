{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options = {
    machineVariables = mkOption {
      type = types.attrs;
      default = { };
      description = "Machine-specific variables for home configuration";
    };
  };
}
