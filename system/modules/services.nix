{ pkgs, ... }:

{
    # fix for Mullvad VPN
    networking.networkmanager.enable = true;
    networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    
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
        
        # fix for Mullvad VPN
        resolved = {
            enable = true;
            dnssec = "true";
            domains = [ "~." ];
            fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
            dnsovertls = "true";
        };

        udev.packages = [
            pkgs.android-udev-rules
        ];

        xserver = {
            # enable = true;

            xkb = {
                layout = "ro";
                variant = "";
            };
        };
    };


    security = {
        # Pipewire
        rtkit.enable = true;
    };
}
