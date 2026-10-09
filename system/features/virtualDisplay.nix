{ pkgs, ... }:

# TODO: Look into EVDI later
{
  boot.kernelParams = [
    "drm.edid_firmware=DP-4:edid/virtualDisplayEDID.bin"
    "video=DP-4:e"
  ];

  hardware.firmware = [
    (pkgs.runCommand "virtualDisplayEDID" { } ''
      mkdir -p $out/lib/firmware/edid
      cp ${./virtualDisplayEDID.bin} $out/lib/firmware/edid/virtualDisplayEDID.bin
    '')
  ];
}
