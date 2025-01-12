{ lib, ... }:

let
  machineVariables = {
    alphicta = {
      gitSigningKey = "0xF23DB4349DDE0FAA";
      gitSigning = true;
    };
    bethium = {
      gitSigningKey = "0x9807678BAB0693F4";
      gitSigning = true;
    };
    zetalyeh = {
      gitSigningKey = "0x";
      gitSigning = false;
    };
  };
in
{
  getMachineVariables = machineName: lib.attrByPath [ machineName ] { } machineVariables;
}
