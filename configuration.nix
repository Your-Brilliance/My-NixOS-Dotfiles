{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  services.power-profiles-daemon.enable = false;

  environment.variables.TERMINAL = "foot";
  environment.variables.EDITOR = "nvim";
  environment.variables.VISUAL = "nvim";

  virtualisation.vmware.host.enable = true;

  services.tlp = {
    enable = true;
    settings = {
    START_CHARGE_THRESH_BAT0 = 40; # Starts charging below 40.
    STOP_CHARGE_THRESH_BAT0 = 85;  # Stops charging at 80.
    USB_AUTO_SUSPEND = 0;
    USB_AUTOSUSPEND_ON_AC = 0;
    USB_AUTOSUSPEND_ON_BAT = 0;
    };
  };

  security.pam.services.hyprlock = {};

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.fprintd.enable = true; 

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true; 
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "Karan-Laptop"; 

  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = [ pkgs.networkmanager-openconnect ];
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

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

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
  };


  users.users.karanxs = {
    isNormalUser = true;
    description = "Karan Shome";
    extraGroups = [ "networkmanager" "wheel" "vmware" ];
    packages = with pkgs; [
    ];
  };  

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users.karanxs = import ./home.nix;
  };

  programs.firefox.enable = true;

  xdg.mime.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "inode/directory" = "yazi.desktop";
    "x-scheme-handler/file" = "yazi.desktop";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-hyprland 
      pkgs.xdg-desktop-portal-gtk 
    ];
    config.common.default = [ "hyprland" ];
  };

  #GNOME PRINTER SHIT
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s";
  };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono

    #For Omnissa
    dejavu_fonts
    freefont_ttf
    liberation_ttf
    noto-fonts

    #For WeebMatrix
    noto-fonts-cjk-sans
    ipafont
    kochi-substitute
    ipafont
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrains Mono" "IPAGothic" ];
      sansSerif = [ "DejaVu Sans" "IPAGothic" ];
      serif = [ "DejaVu Serif" "IPAGothic" ];
    };
  };

  environment.systemPackages = with pkgs; [
    # Emergency tools
    vim
    git
    wget
    curl
    unrar

    # Hardware Control
    brightnessctl
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
  ];

  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05"; 

  environment.etc."current-nixos".source = ./.;
}
