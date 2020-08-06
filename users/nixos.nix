{ config, pkgs, ... }:
with import ../settings.nix; {
  imports = [
    ../packages.nix
    ../window-managers/i3/i3.nix
    #../window-managers/sway/sway.nix
    ../applications/alacritty.nix
    ../applications/kitty.nix
    ../applications/zsh.nix
    ../applications/tmux.nix
    ../applications/skippy.nix
    # editors
    ../applications/vim.nix
    ../applications/rofi.nix
    ../applications/vscodium.nix
    ../applications/firefox.nix
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

  services.picom = {
    enable = true;
    experimentalBackends = true;
    
    blur = true;
    blurExclude = [ "window_type = 'dock'" "window_type = 'desktop'" ];

    shadow = false;
    shadowOffsets = [ (-3) (-3) ];
    shadowOpacity = "0.75";
    noDockShadow = true;
    noDNDShadow = true;

    activeOpacity = "1.0";
    inactiveOpacity = "1.0";
    menuOpacity = "1.0";

    backend = "glx";

    vSync = true;
  };

  programs = {
    home-manager.enable = true; # required by home manager

    bash = {
      enable = true;
      sessionVariables.EDITOR = "vim";
      bashrcExtra = ''
        alias ls='exa'
        alias j='zrs'
        alias z='zrs'
        source /home/nom/.local/share/zrs/z.sh
        PS1="\w> "
      '';
    };

    git = {
      enable = true;
      userName = "monomadic";
      userEmail = "deathdisco@protonmail.com";
    };
  };

  xresources.properties = {
    "Xcursor.theme" = "capitaine-cursors";
    "Xcursor.size" = "76";
    "Xft.dpi" = "155"; # application dpi for most X11 apps
  };

  home.file = {
    ".config/sway" = {
      source = ../window-managers/sway;
      recursive = true;
    };

    ".config/waybar" = {
      source = ../window-managers/sway/waybar;
      recursive = true;
    };

    ".config/ranger" = {
      source = ../applications/ranger;
      recursive = true;
    };

    # (manually do this instead)
    # ".templates" = {
    #   source = ../templates;
    #   recursive = true;
    # };

    ".picom.conf" = {
      source = ../window-managers/i3/picom.conf;
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

    ".config/i3/status.toml".source = ../window-managers/i3/i3status-rust.toml;
  };

  home = {
    packages = with pkgs; [
      brave
      sublime3
      capitaine-cursors
      tdesktop
      signal-desktop
    ];

    sessionVariables = {
      EDITOR = "vim";
      LANG = "en_US.UTF-8";
      PATH = "~/.cargo/bin:$PATH";
    };

    stateVersion = "19.09";
  };
}
