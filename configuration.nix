{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  services.power-profiles-daemon.enable = false;

  environment.variables.EDITOR = "nvim";
  environment.variables.VISUAL = "nvim";

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
  programs.niri.enable = true;
  programs.hyprland.enable = true;  
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
  programs.nm-applet.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };  

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.karanxs = import ./home.nix;
  };

  programs.firefox.enable = true;

  xdg.mime.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
  };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

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
