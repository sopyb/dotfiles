{ lib, config, ... }:

let
  machineVariables = {
    alphicta = {
      gitSigningKey = "0xF23DB4349DDE0FAA";
    };
    bethium = {
      gitSigningKey = "0x9807678BAB0693F4";
    };
  };
in
{
  getMachineVariables = machineName: lib.attrByPath [ machineName ] { } machineVariables;
}
