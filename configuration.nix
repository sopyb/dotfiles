
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ inputs, config, pkgs, options, lib, ... }:

{
  # nix.trustedUsers = [ "root" "@wheel" ];

  # hardware.xone.enable = true; # Stick died
  hardware.xpadneo.enable = true;

  hardware.opentabletdriver.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
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
  services.desktopManager.plasma6.enable = true;
  
  environment.variables = lib.mkForce {
      QT_STYLE_OVERRIDE = "kvantum";
    };
 

  services.displayManager.sddm.wayland.enable = true;
  
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
  sound.enable = true;
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
  users.defaultUserShell = pkgs.zsh;
  users.users.sopy = {
    isNormalUser = true;
    useDefaultShell = true;
    description = "sopy";
    extraGroups = [ "networkmanager" "wheel" "dialout" "plugdev" "adbusers" ];
    packages = with pkgs; [
      peaclock
      # config.nur.repos.nltch.spotify-adblock
      spotify
      config.nur.repos.minion3665.monocraft

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
      (jetbrains.plugins.addPlugins jetbrains.rust-rover ["github-copilot"])
      (jetbrains.plugins.addPlugins jetbrains.pycharm-professional ["github-copilot"])
      (jetbrains.plugins.addPlugins jetbrains.phpstorm ["github-copilot"])
      (jetbrains.plugins.addPlugins jetbrains.idea-ultimate ["github-copilot"])
      (jetbrains.plugins.addPlugins jetbrains.datagrip ["github-copilot"])
      (jetbrains.plugins.addPlugins jetbrains.clion ["github-copilot"])
      vscode
      arduino-ide
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    direnv
    wl-clipboard

    devenv
  
    argyllcms
    colord-kde

    
    kdePackages.filelight
    alacritty 

    lact

    android-tools
    scrcpy
  
# zip stuff
    zip
    unzip
    p7zip
    

# terminal utils
    curl
    wget
    git
	  eza
    micro
    killall
    fastfetch
    hyfetch
    blahaj
    ponysay
    gnupg

	  podman

# php tooling
    php83
# MS SQL Server
    php83Extensions.sqlsrv
    sqlcmd

# java tooling
	  maven
    # jdk8_headless
    # jdk11_headless
    # jdk17_headless
    jdk21_headless
    staruml

# javascript tooling
	nodejs_20
	bun

# rust tooling
	cargo

# go tooling
	go

# cpp tooling
	cmake
	clang-tools
	
	ninja

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
  
  # nix.settings.trustedUsers = [ "root" "@wheel" ];

  programs = {
    adb.enable = true;
    
    noisetorch.enable = true;
  
  	nix-ld = {
  	  enable = true;

  	  libraries = with pkgs; [
  	    SDL
        SDL2
   	    SDL2_image
        SDL2_mixer
   	    SDL2_ttf
        SDL_image
        SDL_mixer
  	    SDL_ttf
  	    alsa-lib
        at-spi2-atk
        at-spi2-core
        atk
        bzip2
        cairo
        cups
        curlWithGnuTls
        dbus
        dbus-glib
        desktop-file-utils
        e2fsprogs
        expat
        flac
        fontconfig
        freeglut
        freetype
        fribidi
        fuse
        fuse3
        gdk-pixbuf
        glew110
        glib
        gmp
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-ugly
        gst_all_1.gstreamer
        gtk2
        harfbuzz
        icu
        keyutils.lib
        libGL
        libGLU
        libappindicator-gtk2
        libcaca
        libcanberra
        libcap
        libclang.lib
        libdbusmenu
        libdrm
        libgcrypt
        libgpg-error
        libidn
        libjack2
        libjpeg
        libmikmod
        libogg
        libpng12
        libpulseaudio
        librsvg
        libsamplerate
        libthai
        libtheora
        libtiff
        libudev0-shim
        libusb1
        libuuid
        libvdpau
        libvorbis
        libvpx
        libxcrypt-legacy
        libxkbcommon
        libxml2
        mesa
        nspr
        nss
        openssl
        p11-kit
        pango
        pixman
        python3
        speex
        stdenv.cc.cc
        tbb
        udev
        vulkan-loader
        wayland
        xorg.libICE
        xorg.libSM
        xorg.libX11
        xorg.libXScrnSaver
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXft
        xorg.libXi
        xorg.libXinerama
        xorg.libXmu
        xorg.libXrandr
        xorg.libXrender
        xorg.libXt
        xorg.libXtst
        xorg.libXxf86vm
        xorg.libpciaccess
        xorg.libxcb
        xorg.xcbutil
        xorg.xcbutilimage
        xorg.xcbutilkeysyms
        xorg.xcbutilrenderutil
        xorg.xcbutilwm
        xorg.xkeyboardconfig
        xz
        zlib
      ];
    };     
    # zsh = {
    #   enable = true;

	  # enableCompletion = true;
	  # autosuggestions.enable = true;
  
    #   enableGlobalCompInit = false;
   	#   syntaxHighlighting.enable = true;
    # };
    
    # direnv = {
    #   enable = true;
    #   package = pkgs.direnv;
    #   silent = false;
    #   loadInNixShell = true;
    #   direnvrcExtra = "";
    #   nix-direnv = {
    #     enable = true;
    #     package = pkgs.nix-direnv;
    #   };
    # };

    # htop = {
    #   enable = true;
    #   settings.show_cpu_temperature = 1;
    # };
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
