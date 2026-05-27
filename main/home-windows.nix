{ config, pkgs, inputs, ... }:

{
  home.username = "karanxs";
  home.homeDirectory = "/home/karanxs";

  home.packages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
    gnome-shell-extensions
    gnomeExtensions.desktop-icons-ng-ding
    gnomeExtensions.night-theme-switcher
    fluent-gtk-theme
    gnome-terminal
    gnome-text-editor
    microsoft-edge

    (pkgs.stdenvNoCC.mkDerivation {
      pname = "segoe-ui-fonts";
      version = "1.0";
      src = pkgs.fetchFromGitHub {
        owner = "mrbvrz";
        repo = "segoe-ui-linux";
        rev = "master";
        hash = "sha256-0KXfNu/J1/OUnj0jeQDnYgTdeAIHcV+M+vCPie6AZcU="; 
      };
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp font/*.ttf $out/share/fonts/truetype/
      '';
    })

  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Win11";
      package = pkgs.stdenvNoCC.mkDerivation {
        pname = "win11-icon-theme";
        version = "master";
        src = pkgs.fetchFromGitHub {
          owner = "yeyushengfan258";
          repo = "Win11-icon-theme";
          rev = "main"; 
          hash = "sha256-+GtOkOVSWlNTdKSs0R86LhnpbBZ21Y0ML3V8pwDUUSc="; 
        };
        nativeBuildInputs = [ pkgs.gtk3 pkgs.bash pkgs.util-linux ];
        dontFixup = true; 
        installPhase = ''
          mkdir -p $out/share/icons
          patchShebangs install.sh
          ./install.sh -d $out/share/icons -n Win11
          ./install.sh -d $out/share/icons -n Win11-dark
          find $out/share/icons -mindepth 1 -maxdepth 1 -not -name "Win11" -not -name "Win11-dark" -exec rm -rf {} +
          for theme in $out/share/icons/*; do
            if [ -d "$theme" ] && [ -f "$theme/index.theme" ]; then
              ${pkgs.gtk3}/bin/gtk-update-icon-cache -f -q -t "$theme"
            fi
          done
        '';
      };
    };
  };

  dconf.settings = {
    "org/gnome/gnome-screenshot" = {
      auto-save-directory = "file:///home/karanxs/Pictures/Screenshots/";
    };
    "org/gnome/shell/extensions/screenshot-window-sizer" = {
      last-directory = "file:///home/karanxs/Pictures/Screenshots/";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "ding@rastersoft.com"
        "nightthemeswitcher@romainvigier.fr"
      ];
    };
    "org/gnome/shell/extensions/ding" = {
      icon-width = 64; 
      num-lines = 3;
      icon-size = "standard"; 
    };
    "org/gnome/desktop/interface" = {
      icon-theme = "Win11";
      gtk-theme = "Fluent-Dark";
      color-scheme = "prefer-dark";
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "Fluent-Light";
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/karanxs/Downloads/Wallpapers/Win11-Light.jpg";
      picture-uri-dark = "file:///home/karanxs/Downloads/Wallpapers/Win11-Dark.jpg";
    };

    "org/gnome/shell/extensions/nightthemeswitcher/gtk-variants" = {
      day = "Fluent-Light";
      night = "Fluent-Dark";
    };
    "org/gnome/shell/extensions/nightthemeswitcher/shell-variants" = {
      day = "Fluent-Light";
      night = "Fluent-Dark";
    };
    "org/gnome/shell/extensions/nightthemeswitcher/icon-variants" = {
      day = "Win11";
      night = "Win11-dark"; 
    };
    "org/gnome/shell/extensions/nightthemeswitcher/time" = {
      manual-schedule = false; 
    };

    "org/gnome/shell/extensions/nightthemeswitcher/commands" = {
      nightthemeswitcher-mode = 1; 
    };

    "org/gnome/desktop/interface" = {
      font-name = "Segoe UI Light 11";
    };
    "org/gnome/desktop/interface" = {
      document-font-name = "FreeSans 12";
    };
    "org/gnome/desktop/interface" = {
      monospace-font-name = "Adwaita Mono 12";
    };
  };

  services.swaync.enable = true;

  home.sessionVariables = {
    EDITOR = "nano";
    VISUAL = "gnome-text-editor"; 
    TERMINAL = "gnome-terminal"; 
    GTK_USE_PORTAL = "1";
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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      "x-scheme-handler/file" = [ "org.gnome.Nautilus.desktop" ];
    };
  };

  home.stateVersion = "25.11"; 

  home.file = {
    ".config/nvim" = {
      source = ../nvim;
      recursive = true; 
    };
  }; 
  
  programs.home-manager.enable = true;
}

