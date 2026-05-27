{ config, pkgs, inputs, ... }:

{
  home.username = "karanxs";
  home.homeDirectory = "/home/karanxs";

  services.swaync.enable = true;

  home.sessionVariables = {
    EDITOR = "nano";
    VISUAL = "gnome-text-editor"; 
    TERMINAL = "gnome-terminal"; 
    GTK_USE_PORTAL = "1";
  };
  
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      "x-scheme-handler/file" = [ "org.gnome.Nautilus.desktop" ];
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

      "startup_commands" = "toggle_horizontal_scroll_lock;fit_to_page_width_smart";

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
    extraPackages = with pkgs; [
      lua-language-server
      nil
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
  
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
  };

  home.stateVersion = "25.11"; 

  home.file = {
    ".config/waybar".source = ../waybar;
    ".config/rofi".source = ../rofi;
    ".config/foot".source = ../foot;
    ".config/hypr".source = ../hypr;
    #".config/yazi".source = ../yazi;
    #".config/wlogout".source = ../wlogout;
    ".config/wal/templates".source = ../wal/templates;
    ".config/nvim" = {
      source = ../nvim;
      recursive = true; 
    };
  }; 
  
  programs.home-manager.enable = true;
}
