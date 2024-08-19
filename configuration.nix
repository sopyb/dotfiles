

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ inputs, config, pkgs, options, lib, ... }:

{
  hardware.opentabletdriver.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.{
  time.timeZone = "EET";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the KDE Plasma Desktop Environment.
  # ! TODO: Move plasma related stuff to it's own file
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  # services.desktopManager.plasma6.enable = true;

  # environment.variables = lib.mkForce {
  #     QT_STYLE_OVERRIDE = "kvantum";
  #   };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sopy = {
    packages = with pkgs; [
      mpv
      peaclock
      config.nur.repos.nltch.spotify-adblock
      spotify
      protontricks

      obsidian
      openboard
      krita
      

      tor-browser
      deluge
      firefox-devedition
      vivaldi
      vivaldi-ffmpeg-codecs
      ladybird

      onlyoffice-bin
      
      thunderbird

      heroic
      steam
      itch
      discover-overlay
      goverlay
      mangohud
      prismlauncher
      gamescope
      osu-lazer-bin

      bottles
      matlab
      vscode
      arduino-ide
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kdenlive

    libnotify
    # inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    kdePackages.filelight
    kdePackages.partitionmanager

    # kdePackages.qtstyleplugin-kvantum
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # services.blueman.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
}
