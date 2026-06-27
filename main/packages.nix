{ pkgs, inputs, ... }:

{
    imports = [
      inputs.slippi.homeManagerModules.default
    ];

    slippi-launcher.isoPath = "/home/karanxs/Downloads/Melee/melee.iso"; 
    slippi-launcher.launchMeleeOnPlay = false;
    
    home.packages = with pkgs; [
    # --- Desktop & Terminal Toys ---
    superfile joshuto wl-clipboard wl-clip-persist kitty foot alacritty
    waybar hyprpaper hypridle hyprlock hyprshot hyprpicker swayosd avizo rofi fuzzel
    wlogout pywal ripgrep fd quickshell bat fastfetch cava kdePackages.dolphin thunar
    home-manager 
 
    # --- Applications ---
    (pkgs.vivaldi.override {
      commandLineArgs = [
        "--ozone-platform=wayland"
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
      ];
    })

    inputs.zen-browser.packages.x86_64-linux.default fzf zoom-us
    btop htop powertop unimatrix tmatrix cmatrix zip unzip eza feh mpv
    pavucontrol pulsemixer onlyoffice-desktopeditors kooha pomodoro-gtk
    anki thokr ttyper smassh mangohud protonup-qt gparted

    # --- Development & Languages ---
    gcc gnumake nodejs prettier ghc cabal-install jdk21
    rustc cargo opam ocaml ocamlPackages.utop dune_3 imagemagick
    luajitPackages.magick lua-language-server vscode-langservers-extracted
    mongosh mongodb-compass sqlitebrowser vscodium basex

    # --- Specialized Environments ---
    (python3.withPackages (ps: with ps; [ pynvim jupyter-client cairosvg kaleido pnglatex pyperclip plotly ]))
    texlive.combined.scheme-full xdotool texlab neovim-remote

    # --- Games ---
    gnuchess gnushogi chess-tui uchess gambit-chess wine64 
    
    (heroic.override {
      extraPkgs = pkgs': with pkgs'; [
        gamescope
        gamemode
      ];
    })
  ];
}
