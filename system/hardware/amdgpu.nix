{ pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

  # systemd.tmpfiles.rules = [
  # "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  # ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.variables.AMD_VULKAN_ICD = "RADV";
  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };
}
