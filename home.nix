{ config, pkgs, inputs, ... }:

{
  home.username = "karanxs";
  home.homeDirectory = "/home/karanxs";


  imports = [
  ];

  services.swaync.enable = true;
  
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      lua-language-server
      # Add other LSPs here, e.g., pyright, nil, etc.
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  }; 
  

xdg.desktopEntries.yazi = {
  name = "Yazi";
  exec = "foot -e yazi %u"; # Added -e for foot to execute the command correctly
  icon = "yazi";
  terminal = false;
  mimeType = [ "inode/directory" ];
};

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
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
      vpn = "nmcli con up 'BU VPN'";
      vpnoff = "nmcli con down 'BU VPN'"; 
      check = "nmcli con show --active";
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
    quickshell
    
    # --- Apps & Utilities ---
    vivaldi
    yazi
    kdePackages.dolphin
    zoom-us
    zathura
    btop
    htop
    powertop
    cmatrix
    unimatrix
    fastfetch
    cava
    zip
    unzip
    eza
    feh
    mpv
    vscode
    
    # --- Development Environment ---
    gcc
    gnumake
   (python3.withPackages (ps: with ps; [ 
      pynvim 
      jupyter-client
      cairosvg 
      kaleido
      pnglatex 
      pyperclip
      plotly   
    ]))
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
    imagemagick
    luajitPackages.magick
    lua-language-server
  ];

  home.file = {
    ".config/waybar".source = ./waybar;
    ".config/rofi".source = ./rofi;
    ".config/foot".source = ./foot;
    ".config/hypr".source = ./hypr;
    ".config/yazi".source = ./yazi;
    #".config/wlogout".source = ./wlogout;
    ".config/wal/templates".source = ./wal/templates;
    ".config/nvim" = {
      source = ./nvim;
      recursive = true; 
    };
  }; 
  
  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
