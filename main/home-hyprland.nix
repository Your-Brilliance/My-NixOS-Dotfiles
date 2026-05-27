{ config, pkgs, inputs, ... }:

{
  home.username = "karanxs";
  home.homeDirectory = "/home/karanxs";

  services.swaync.enable = true;
  services.swayosd.enable = true;
  
  wayland.windowManager.hyprland.configType = "hyprlang";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "foot";
    GTK_USE_PORTAL = "1"; # Moved from configuration.nix too
  };
  
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "sioyek.desktop" ];
      "inode/directory" = [ "yazi.desktop" ];
      "x-scheme-handler/file" = [ "yazi.desktop" ];
    };
  };

  programs.sioyek = {
    enable = true;
    bindings = {
      "toggle_dark_mode" = "i";
      "fit_to_page_width" = "w";
      "zoom_in" = "=";
      "zoom_out" = "-";
      "toggle_horizontal_scroll_lock" = "'";
    };

    config = {
      # --- The Theme ---
      "default_dark_mode" = "1";
      "background_color" = "0.18 0.18 0.18";           # Changed to dark background
      "dark_mode_background_color" = "0.18 0.18 0.18"; # Dark mode paper (Grey)
      "dark_mode_text_color" = "0.8 0.8 0.8";

      "startup_commands" = [ "toggle_horizontal_scroll_lock" "fit_to_page_width_smart" ];

      # Zoom sensitivity
      "zoom_inc" = "1.05";

      "should_launch_new_window" = "1";

      # Page gaps
      "page_separator_width" = "20";
      "page_separator_color" = "0.15 0.15 0.15";             # Light mode gaps
      "dark_mode_page_separator_color" = "0.15 0.15 0.15";   # Dark mode gaps (Matches)
    };
  };

  programs.yazi = {
    enable = true;
    settings = {
      opener = {
        pdf_viewer = [
          { run = ''sioyek "$@" ''; orphan = true; desc = "Open PDF"; }
        ];
        image_viewer = [
          { run = ''feh "$@" ''; orphan = true; desc = "Open Image"; }
        ];
        video_player = [
          { run = ''mpv "$@" ''; orphan = true; desc = "Open Video"; }
        ];
        editor = [
          { run = ''nvim "$@" ''; block = true; desc = "Edit in Neovim"; }
        ];
      };
      open = {
        rules = [
          { mime = "application/pdf"; use = "pdf_viewer"; }
          { mime = "image/*"; use = "image_viewer"; }
          { mime = "video/*"; use = "video_player"; }
          { mime = "text/*"; use = "editor"; }
        ];
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      credential.helper = "store";
    };
  };
  
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;

    extraPackages = with pkgs; [
      lua-language-server
      nil
      # Web Dev (HTML, CSS, JSON, ESLint)
      vscode-langservers-extracted 

      pyright       # Python
      clang-tools   # Provides clangd for C/C++
      rust-analyzer # Rust
      
      ocamlPackages.ocaml-lsp # OCaml
      haskell-language-server # Haskell

      jdt-language-server     # Java (jdtls)
      
      # Data / Markup
      sqls    # SQL
      lemminx # XML

      # --- THE MISSING TOOLS FOR TREESITTER ---
      gcc
      gnumake
      tree-sitter
    ];
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = '' # used for less common options, intelligently combines if defined in multiple places.
    ...
    '';
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

  home.stateVersion = "25.11"; 

  home.file = {
    ".config/waybar".source = 
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/waybar";
    ".config/rofi".source = 
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/rofi";
    ".config/foot".source = 
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/foot";
    ".config/hypr".source = 
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr";
    #".config/yazi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/yazi;
    #".config/wlogout".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/wlogout;
    ".config/wal/templates".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/wal/templates";
    ".config/nvim" = {
      source = ../nvim;
      recursive = true;
    };
    "Downloads/Wallpapers".source = 
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/Wallpapers";
  }; 

  programs.home-manager.enable = true;
}
