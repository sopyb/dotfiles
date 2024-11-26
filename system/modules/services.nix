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

        printing.enable = true;

        udev.packages = [
            pkgs.android-udev-rules
            pkgs.openrgb
        ];

        xserver = {
            # enable = true;

            xkb = {
                layout = "ro";
                variant = "";
            };
        };

        fwupd.enable = true;

        hardware.openrgb.enable = true;
    };


    security = {
        # Pipewire
        rtkit.enable = true;
    };
}
