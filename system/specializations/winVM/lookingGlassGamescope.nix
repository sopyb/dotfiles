{ pkgs, ... }:

{
  specialisation = {
    lookingGlassGamescope = {
      inheritParentConfig = false;
      configuration = {

        imports = [
          ../../hw_cfg_alphicta.nix
          ../../modules/desktop.nix
        ];

        config = {
          system.nixos.tags = [ "passthrough" "vm" ];
          boot.loader.grub.configurationName = ''Windows VM" --class "windows'';

          # Alphicta
          boot.initrd.preDeviceCommands = ''
            DEVS="0000:01:00.0 0000:01:00.1"
            for DEV in $DEVS; do
              echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
            done
            modprobe -i vfio-pci
          '';

          systemd.services.auto-start-windows-vm = {
            description = "Auto-start Windows VM with Looking Glass and shutdown after exit";
            wantedBy = [ "multi-user.target" ];
            after = [ "network.target" "libvirtd.service" ];
            requires = [ "libvirtd.service" ];
            serviceConfig = {
              Type = "simple";
              User = "root"; # Need root to start VM and later become sopy
              ExecStart = "${pkgs.writeShellScriptBin "start-windows-vm-service" ''
              sleep 3
              
              # Start the Windows VM (replace win10 with your VM name)
              virsh start WinVMNativeLike || exit 1
              
              # Make sure DISPLAY is set (assuming sopy is using :0)
              export DISPLAY=:0
              
              # Run looking-glass-client as user sopy
              su sopy -c "LIBINPUT_CONFIG_TAP=1 gamescope -- looking-glass-client" &
              LG_PID=$!
              
              # Wait for VM to shut down
              while virsh domstate win10 | grep -q running; do
                sleep 5
              done
              
              # Kill looking-glass-client if it's still running
              if kill -0 $LG_PID 2>/dev/null; then
                kill $LG_PID
              fi
              
              # Shutdown the host system
              echo "VM has stopped, shutting down host system..."
              systemctl poweroff
            ''}/bin/start-windows-vm-service";
              Restart = "no";
            };
          };
        };
      };
    };
  };
}
