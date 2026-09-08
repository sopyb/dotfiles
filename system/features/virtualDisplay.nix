{ pkgs, ... }:

{
  boot.kernelModules = [ "vkms" ];

  boot.kernelParams = [
    "drm.edid_firmware=Virtual-1:edid/virtualDisplayEDID.bin"
  ];

  hardware.firmware = [
    (pkgs.runCommand "virtualDisplayEDID" {} ''
      mkdir -p $out/lib/firmware/edid
      cp ${./virtualDisplayEDID.bin} $out/lib/firmware/edid/virtualDisplayEDID.bin
    '')
  ];
}