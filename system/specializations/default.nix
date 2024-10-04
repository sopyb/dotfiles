{ lib, config, extraImports ? [] }:

{
  imports = lib.mkIf (config.specialisation == {}) extraImports;
}
