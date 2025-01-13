{ inputs, system, ... }:

let
  nvidianixpkgs = import inputs.nixpkgs_nvidia470 {
    inherit system;

    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
    };
  };
in
{
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    open = false;
    nvidiaSettings = true;
    package = nvidianixpkgs.linuxPackages_6_6.nvidiaPackages.legacy_470;
  };

  boot.kernelPackages = nvidianixpkgs.linuxPackages_6_6;
}
