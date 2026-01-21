{ config, pkgs, inputs, ... }:

{
  home.username = "karanxs";
  home.homeDirectory = "/home/karanxs";


  imports = [
  ];

  services.swaync.enable = true;
  
  programs.neovim = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ns = "git -C ~/dotfiles add . && sudo nixos-rebuild switch --flake ~/dotfiles#Karan-Laptop && hyprctl reload";
      lsr = "\\ls";
      ls = "exa --icons --group-directories-first";
      la = "exa -a --icons --group-directories-first";
      ll = "exa -lh --icons --group-directories-first";
      lt = "exa --icons --tree";
    };
  };

  home.stateVersion = "25.11"; 

  home.packages = with pkgs; [
    # --- Desktop & UI ---
    wl-clipboard
    wl-clip-persist
    kitty
    foot
    alacritty
    waybar
    hyprpaper
    hypridle
    hyprlock
    rofi
    fuzzel
    wlogout
    pywal
    ripgrep
    fd
    lua-language-server
    
    # --- Apps & Utilities ---
    yazi
    kdePackages.dolphin
    zoom-us
    zathura
    btop
    htop
    powertop
    cmatrix
    fastfetch
    cava
    zip
    unzip
    eza
    feh
    mpv
    
    # --- Development Environment ---
    gcc
    gnumake
    python3
    ghc
    cabal-install
    jdk21
    nodejs        
    nodePackages.prettier
    rustc
    cargo
    ocaml
    ocamlPackages.utop
    dune_3
  ];

  home.file = {
    ".config/waybar".source = ./waybar;
    ".config/rofi".source = ./rofi;
    ".config/foot".source = ./foot;
    ".config/hypr".source = ./hypr;
    ".config/yazi".source = ./yazi;
    #".config/wlogout".source = ./wlogout;
    ".config/wal/templates".source = ./wal/templates;
    ".config/nvim".source = ./nvim;
  }; 
  
  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
