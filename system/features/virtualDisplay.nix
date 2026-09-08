{ pkgs, ... }:

{
  boot.kernelParams = [
    "drm.edid_firmware=DP-1:edid/virtualDisplayEDID.bin"
    "video=DP-1:e"
  ];

  hardware.firmware = [
    (pkgs.runCommand "virtualDisplayEDID" { } ''
      mkdir -p $out/lib/firmware/edid
      cp ${./virtualDisplayEDID.bin} $out/lib/firmware/edid/virtualDisplayEDID.bin
    '')
  ];
}
