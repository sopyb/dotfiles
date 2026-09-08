{ config, pkgs, ... }:

{
  specialisation = {
    disabledDgpu = {
      inheritParentConfig = true;
      configuration = {

        config = {
          system.nixos.tags = [ "passthrough" ];
          boot.loader.grub.configurationName = ''dGPU Disabled" --class "nixos'';
          boot.kernelParams = [ "amd_iommu=on" "pcie_aspm=off" ];

          boot.initrd.availableKernelModules = [ "vfio-pci" "vfio" "kvmfr" ];
          boot.initrd.kernelModules = [ "vfio-pci" "vfio" "kvmfr" ];

          boot.extraModprobeConfig = ''
            options kvmfr static_size_mb=32
            options ec_sys write_support=Y
          '';

          boot.extraModulePackages = with config.boot.kernelPackages; [ kvmfr ];

          # Alphicta
          boot.initrd.systemd.services.disable-dgpu-vfio-bind = {
            description = "Bind dGPU functions to vfio-pci in initrd";
            wantedBy = [ "initrd.target" ];
            after = [ "systemd-udevd.service" ];

            path = [ pkgs.kmod ];
            script = ''
              DEVS="0000:01:00.0 0000:01:00.1"
              for DEV in $DEVS; do
                if [ -e "/sys/bus/pci/devices/$DEV/driver_override" ]; then
                  echo "vfio-pci" > "/sys/bus/pci/devices/$DEV/driver_override"
                fi
              done

              modprobe -i vfio-pci || true
            '';
            serviceConfig.Type = "oneshot";
          };
        };
      };
    };
  };
}
