{ pkgs, ... }:

{
  specialisation = {
    disabledDgpu = {
      inheritParentConfig = true;
      configuration = {

        config = {
          system.nixos.tags = [ "passthrough" ];
          boot.loader.grub.configurationName = ''dGPU Disabled" --class "nixos'';
          boot.kernelParams = [ "amd_iommu=on" "pcie_aspm=off" ];
            

          # Alphicta
          boot.initrd.preDeviceCommands = ''
            DEVS="0000:01:00.0 0000:01:00.1"
            for DEV in $DEVS; do
              echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
            done
            modprobe -i vfio-pci
          '';
        };
      };
    };
  };
}
