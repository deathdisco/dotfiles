{ config, pkgs, ... }:
with import ../settings.nix; {
  imports = [
    ../packages.nix
    ../window-managers/i3/i3.nix
    ../window-managers/sway/sway.nix
    ../window-managers/hidpi.nix
    ../applications/alacritty.nix
    ../applications/kitty.nix
    #../applications/zsh.nix
    #../applications/tmux.nix
    #../applications/skippy.nix
    # editors
    #../applications/vim.nix
    ../applications/rofi.nix
    ../applications/vscodium.nix
    ../applications/firefox.nix
    #../applications/wayland.nix
    ../applications/pass.nix

    ../collections/audio.nix
  ];

  nixpkgs.config.xsession.pointerCursor = nixpkgs.capitaine-cursors;

  # should likely be in nixos config, not hm
  nixpkgs.config = {
    allowUnfree = true;

    environment.variables = {
      EDITOR = "vim";
      PATH = "~/.bin:~/.cargo/bin:$PATH";
    };

    environment.profileVariables = (i: { PATH = [ "${i}/cargo/bin" ]; });

    # fonts.fontconfig.enable = true;
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
        # source /home/nom/.local/share/zrs/z.sh
        PS1="\w> "
      '';
    };

    git = {
      enable = true;
      userName = "monomadic";
      userEmail = "deathdisco@protonmail.com";
    };
  };

  gtk.theme.package = pkgs.pop-gtk-theme;
  gtk.theme.name = "PopOS";

  home.file = {

    ".config/waybar" = {
      source = ../window-managers/sway/waybar;
      recursive = true;
    };

    ".config/ranger" = {
      source = ../applications/ranger;
      recursive = true;
    };

    ".xinitrc".text = ''
      xrdb ~/.Xresources
      exec i3
      # picom -b --config ~/.config/picom.conf
    '';

    ".config/mimeapps.list".text = ''
      [Default Applications]
      inode/directory=ranger.desktop
    '';

    ".local/share/applications/ranger.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=ranger
      Comment=Launches the ranger file manager
      Icon=utilities-terminal
      Terminal=false
      Exec=alacritty -e ranger
      Categories=ConsoleOnly;System;FileTools;FileManager
      MimeType=inode/directory;
      Keywords=File;Manager;Browser;Explorer;Launcher;Vi;Vim;Python
    '';

    # (manually do this instead)
    # ".templates" = {
    #   source = ../templates;
    #   recursive = true;
    # };

    # .desktop files
    #".local/share/applications" = {
    #  source = ./applications/desktopfiles;
    #  recursive = true;
    #};

    #".config/Typora/themes" = {
    #  source = ./typora/themes;
    #  recursive = true;
    #};

    # ".config/i3/status.toml".source = ../window-managers/i3/i3status-rust.toml;
  };

  # xdg.mimeApps = pkgs.lib.mkIf config.lib.gui.enable {
  #   enable = true;
  #   associations.added = {
  #     "inode/directory" = [ "ranger.desktop" ];
  #     # "text/html" = [ "firefox.desktop" ];
  #     # "x-scheme-handler/chrome" = [ "firefox.desktop" ];
  #     # "x-scheme-handler/http" = [ "firefox.desktop" ];
  #     # "x-scheme-handler/https" = [ "firefox.desktop" ];
  #   };
  #   defaultApplications = {
  #     # "application/pdf" = [ "org.kde.okular.desktop" ];
  #     # "image/jpeg" = [ "org.kde.gwenview.desktop" ];
  #     # "image/png" = [ "org.kde.gwenview.desktop" ];
  #     "inode/directory" = [ "ranger.desktop" ];
  #     # "text/html" = [ "chromium.desktop" ];
  #     # "x-scheme-handler/chrome" = [ "firefox.desktop" ];
  #     # "x-scheme-handler/http" = [ "firefox.desktop" ];
  #     # "x-scheme-handler/https" = [ "firefox.desktop" ];
  #   };
  # };

  home = {
    packages = with pkgs; [
      brave
      # sublime3
      capitaine-cursors
      tdesktop bc
      signal-desktop
      ffmpegthumbnailer # todo: add to ranger.nix
      ueberzug # todo: add to ranger.nix
      source-code-pro
      pop-gtk-theme
    ];

    sessionVariables = {
      EDITOR = "vim";
      LANG = "en_US.UTF-8";
      PATH = "~/.cargo/bin:$PATH";
    };

    stateVersion = "19.09";
  };
}
