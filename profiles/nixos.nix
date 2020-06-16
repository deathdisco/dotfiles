{ config, pkgs, ... }:
with import ../settings.nix; {
  imports = [
    ../packages.nix
    ../applications/picom.nix
    ../desktop/i3/i3.nix
    # ./desktop/awesome/awesome.nix
    # ./desktop/sway/sway.nix
    # ./package-sets/development.nix
    ../applications/alacritty.nix
    ../applications/kitty.nix
    ../applications/zsh.nix
    ../applications/tmux.nix
    # editors
    ../applications/vim.nix
    ../applications/rofi.nix
    #./applications/graphics.nix
    ../applications/vscodium.nix
  ];

  nixpkgs.config.xsession.pointerCursor = nixpkgs.capitaine-cursors;

  # should likely be in nixos config, not hm
  nixpkgs.config = {
    allowUnfree = true;

    environment.variables = {
      EDITOR = "vim";
      PATH = "~/.cargo/bin:$PATH";
    };

    environment.profileVariables = (i: { PATH = [ "${i}/cargo/bin" ]; });

    fonts.fontconfig.enable = true;
  };

  programs = {
    home-manager.enable = true; # required by home manager

    bash = {
      enable = true;
      sessionVariables.EDITOR = "vim";
      bashrcExtra = ''
        source ~/.nix-profile/etc/profile.d/nix.sh

        alias ls='exa'

        # prompt
        PS1="\w> "

        neofetch --disable gpu
      '';
    };
  };

  xresources.properties = {
    "Xcursor.theme" = "capitaine-cursors";
    "Xcursor.size" = "76";
    "Xft.dpi" = "155"; # application dpi for most X11 apps
  };

  home.file = {
    ".config/sway" = {
      source = ../desktop/sway;
      recursive = true;
    };

    ".config/waybar" = {
      source = ../desktop/sway/waybar;
      recursive = true;
    };

    ".config/ranger" = {
      source = ../applications/ranger;
      recursive = true;
    };

    ".templates" = {
      source = ../templates;
      recursive = true;
    };

    # .desktop files
    #".local/share/applications" = {
    #  source = ./applications/desktopfiles;
    #  recursive = true;
    #};

    #".config/Typora/themes" = {
    #  source = ./typora/themes;
    #  recursive = true;
    #};

    ".config/i3/status.toml".source = ../desktop/i3/i3status-rust.toml;
  };

  home = {
    packages = with pkgs; [ brave sublime3 capitaine-cursors ];

    sessionVariables = {
      EDITOR = "vim";
      LANG = "en_US.UTF-8";
      PATH = "~/.cargo/bin:$PATH";
    };

    stateVersion = "19.09";
  };
}