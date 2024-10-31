{ inputs, ... }: 

{
  environment.systemPackages = [
    inputs.activate-linux.defaultPackage.xf86_64-linux
  ];
}
