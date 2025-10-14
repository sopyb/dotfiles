{ pkgs, ... }:

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
      packages = [
        pkgs.android-udev-rules
      ];

      extraRules = ''
        SUBSYSTEM=="kvmfr", OWNER="sopy", GROUP="kvm", MODE="0660"
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
  };


  security = {
    # Pipewire
    rtkit.enable = true;
  };
}
