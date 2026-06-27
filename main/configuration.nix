{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix   
      ./bashrc.nix
    ];

  services.flatpak.enable = true;
 
 environment.sessionVariables = {
    XDG_DATA_DIRS = [
      "$XDG_DATA_DIRS"
      "$HOME/.local/share/flatpak/exports/share"
      "/var/lib/flatpak/exports/share"
    ];
  };

  #For my speakers
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  #Brightness Control
  hardware.brillo.enable = true;

  programs.nix-ld.enable = true;
  
  environment.variables = {
    GTK_USE_PORTAL = "1";
    MOZ_ENABLE_WAYLAND = "1";       
    NIXOS_OZONE_HWACCEL = "1";  
    STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };
  
  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: with pkgs; [ curl ];
    };
  };

  virtualisation.vmware.host.enable = true;

  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-ce; 
  };

  zramSwap = {  
    enable = true;
    algorithm = "zstd";   # Best compression/speed balance (2026 standard)
    memoryPercent = 50;   # Uses up to 50% of RAM for the swap area
    priority = 100;       # Ensures it is used before any physical swap (Highest Priority)
  };


  programs.dconf.enable = true;

#  programs.dconf.profiles.user.databases = [{
#    settings = {
#      "org/gnome/desktop/interface" = {
#      text-scaling-factor = 1.25; 
#      };
#    };
#  }];


  security.pam.services.hyprlock = {};

  programs.niri.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.fprintd.enable = true; 

  # Enable graphics and 32-bit support for Steam
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };

  # Optimize system performance during gameplay
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true; 
  };

  programs.gamescope.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  #For my speakers
  boot.kernelParams = [ "snd_intel_dspcfg.dsp_driver=3" "i915.enable_guc=3" ];

  networking.hostName = "Karan-Laptop"; 

  services.gnome.gnome-keyring.enable = true;
  
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };

  networking.networkmanager = {
    enable = true;
  };
    
  networking.nameservers = ["1.1.1.1"];

  programs.nm-applet.enable = true;
  security.polkit.enable = true;
  services.dbus.enable = true;
  services.dbus.implementation = "broker";

  systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
};
  

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;


  time.timeZone = "America/New_York";
 
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;

  #services.displayManager.sddm.wayland.enable = true;
  #services.displayManager.ly.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  #services.greetd = {
  #  enable = true;
  #  settings = {
  #    default_session = {
  #      # We point it to the directories where .desktop files live
  #      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${pkgs.hyprland}/share/wayland-sessions:${pkgs.gnome-session}/share/wayland-sessions";
  #      user = "greeter";
  #    };
  #  };
  #};


  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };


  users.users.karanxs = {
    isNormalUser = true;
    description = "Karan Shome";
    extraGroups = [ "networkmanager" "wheel" "vmware" "video" "audio" ];
    packages = with pkgs; [
    ];
  };  


  xdg.portal = {
    enable = true;
    extraPortals = lib.mkForce [ 
      pkgs.xdg-desktop-portal-gtk 
      pkgs.xdg-desktop-portal-hyprland 
    ];
    config.common.default = [ "hyprland" "gtk"];
    config.common."org.freedesktop.impl.portal.Settings" = [ "gtk" ];
  };

  #GNOME PRINTER SHIT
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono

    #For Omnissa
    dejavu_fonts
    freefont_ttf
    liberation_ttf
    noto-fonts
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrains Mono" ];
      sansSerif = [ "DejaVu Sans" ];
      serif = [ "DejaVu Serif" ];
    };
  };

  environment.systemPackages = with pkgs; [
    # Emergency tools
    emacs
    vim
    git
    wget
    curl
    unrar
    appimage-run
    openssl

    # Hardware Control
    fprintd

    # System Essentials
    pciutils
    usbutils
    powertop

    #CS460
    omnissa-horizon-client
    openconnect
    networkmanagerapplet
    (networkmanager-openconnect.override { withGnome = true; })
    polkit_gnome
    sqlitebrowser
  ];

  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true; 

  home-manager.users.karanxs = {
    imports = [ 
      ./packages.nix 
      ./edex.nix 
    ];
  };

  specialisation = {
    windows.configuration = {
      home-manager.users.karanxs = lib.mkForce {
        imports = [ 
          ./packages.nix 
          ./home-windows.nix 
        ];
      };
    };

    mac.configuration = {
      home-manager.users.karanxs = lib.mkForce {
        imports = [ 
          ./packages.nix 
          ./home-mac.nix 
        ];
      };
    };
  };

  system.stateVersion = "25.05"; 

  environment.etc."current-nixos".source = ./.;
}
