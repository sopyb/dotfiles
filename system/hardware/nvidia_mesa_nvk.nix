{ ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };


  # Enable gsp
  boot.kernelParams = [
    "nouveau.config=NvGspRM=1"
    "nouveau.config=NvModesetKms=0"
    "nouveau.debug=info,VBIOS=info,gsp=debug"
  ];

  boot.initrd.kernelModules = [ "nouveau" ];
}
