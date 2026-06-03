{ pkgs, ... }:

let
  adb = "${pkgs.android-tools}/bin/adb";
  lsusb = "${pkgs.usbutils}/bin/lsusb";
in
{
  # fix for Mullvad VPN
  networking.networkmanager.enable = true;

  services = {
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    ratbagd.enable = true;

    printing.enable = true;

    udev = {
      extraRules = ''
        SUBSYSTEM=="kvmfr", OWNER="sopy", GROUP="kvm", MODE="0660"
        ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="2833", TAG+="systemd", ENV{SYSTEMD_WANTS}="wivrn-adb-tunnel.service"
      '';
    };

    flatpak.enable = true;

    xserver = {
      # enable = true;

      xkb = {
        layout = "ro";
        variant = "";
      };
    };

    fwupd.enable = true;

    
      wivrn = {
        enable = true;
        openFirewall = true;

        autoStart = true;

        package = (pkgs.wivrn.override { cudaSupport = true; });
      };
  };

  systemd.services."wivrn-adb-tunnel" = {
      description = "WiVRn ADB reverse tunnel (used by udev)";
      serviceConfig = {
        Type = "oneshot";
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 3";
        ExecStart = pkgs.writeShellScript "wivrn-adb-tunnel" ''
          set -euo pipefail
          serial=$(${lsusb} -vd 2833: | grep iSerial | awk '{print $3}' | head -n1 || true)
          [ -n "$serial" ] || { echo "device not found"; exit 1; }
          ${adb} -s "$serial" reverse tcp:9757 tcp:9757
        '';
      };
    };


  security = {
    # Pipewire
    rtkit.enable = true;
  };
}
