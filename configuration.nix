

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
    services.xserver.enable = true;
    # services.xserver.displayManager.gdm.enable = true;
    # services.xserver.desktopManager.gnome.enable = true;
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
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.variables = lib.mkForce {
      QT_STYLE_OVERRIDE = "kvantum";
    };
 
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ro";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sopy = {
    packages = with pkgs; [
    vlc
      peaclock
      # config.nur.repos.nltch.spotify-adblock
      spotify
      protontricks

      obsidian
      openboard
      krita
      
      teams-for-linux
      element-desktop
      zapzap
      zulip
      zoom-us
      (vesktop.overrideAttrs (finalAttrs: previousAttrs: {
        desktopItems = [
          (makeDesktopItem {
            name = "Clementine";
            exec = "vesktop %u";
            icon = "clementine";
            desktopName = "Clementine";
          })
        ];
      }))

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
      discover-overlay
      goverlay
      mangohud
      prismlauncher
      gamescope
      osu-lazer-bin

      bottles
      matlab
      (jetbrains.plugins.addPlugins jetbrains.webstorm ["github-copilot"])
      # (jetbrains.plugins.addPlugins jetbrains.rust-rover ["github-copilot"])
      # (jetbrains.plugins.addPlugins jetbrains.pycharm-professional ["github-copilot"])
      # (jetbrains.plugins.addPlugins jetbrains.phpstorm ["github-copilot"])
      # (jetbrains.plugins.addPlugins jetbrains.idea-ultimate ["github-copilot"])
      # (jetbrains.plugins.addPlugins jetbrains.datagrip ["github-copilot"])
      (jetbrains.plugins.addPlugins jetbrains.clion ["github-copilot"])
      vscode
      arduino-ide
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	kdenlive
	ffmpeg

	libnotify
	
	
  
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    direnv
    wl-clipboard

    devenv
  
    argyllcms
    colord-kde

    
    kdePackages.filelight
    kdePackages.partitionmanager

    lact

    android-tools
    scrcpy
  
# zip stuff
    

# terminal utils
    curl
    wget
    git
	  eza
    micro
    killall
    blahaj
    ponysay
    gnupg

	  podman

	llvmPackages.mlir

	xwaylandvideobridge

	kdePackages.qtstyleplugin-kvantum
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs = {
    adb.enable = true;

    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
        custom = {
          start = "notify-send -a 'Gamemode' 'Optimizations activated'";
          end = "notify-send -a 'Gamemode' 'Optimizations deactivated'";
        };
      };
    };
    
    noisetorch.enable = true;

  };

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
