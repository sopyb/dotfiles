{ inputs, ... }:

{
  environment.systemPackages = [
    inputs.activate-linux.defaultPackage.x86_64-linux
  ];
}
