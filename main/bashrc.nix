{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;

    # In System configuration, use interactiveShellInit instead of bashrcExtra/initExtra
    
    promptInit = ''
      export PS1="\W: "
    '';

    interactiveShellInit = ''
      # Use hardcoded path for system-level bashrc
      if [ -f "/home/karanxs/.opam/opam-init/init.sh" ]; then
        . "/home/karanxs/.opam/opam-init/init.sh" > /dev/null 2> /dev/null || true
      fi
    '';

    shellAliases = {
      # System Management
      logout = "gnome-session-quit --logout --no-prompt";
      ns = "cd ~/dotfiles && git add . && cd main && sudo nixos-rebuild switch --flake .#Karan-Laptop && hyprctl reload";
      winset = ''
        cd ~/dotfiles/main && \
        git add . && \
        sudo nixos-rebuild switch --flake .#Karan-Laptop && \
        sudo /run/current-system/specialisation/windows/bin/switch-to-configuration switch
      '';
      macset = ''
        cd ~/dotfiles/main && \
        git add . && \
        sudo nixos-rebuild switch --flake .#Karan-Laptop && \
        sudo /run/current-system/specialisation/mac/bin/switch-to-configuration switch
      '';
      
      # Quick Specialization Switching
      gowin = "sudo /run/current-system/specialisation/windows/bin/switch-to-configuration switch";
      gomac = "sudo /run/current-system/specialisation/mac/bin/switch-to-configuration switch";
      gohypr = "sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch";

      # File Navigation and Listing
      lsr = "\\ls";
      ls = "eza --icons --group-directories-first";
      la = "eza -a --icons --group-directories-first";
      ll = "eza -lh --icons --group-directories-first";
      lt = "eza --icons --tree";
      fz = "cd $(find * -type d | fzf )";
      nv = "nvim $(fzf --preview='bat --color=always --style=numbers --line-range=:500 {}')";

      # Utilities
      vpn = "nmcli con up 'BU VPN'";
      vpnoff = "nmcli con down 'BU VPN'";
      check = "nmcli con show --active";
      edex = "edex-ui-patched";
    };
  };
}
