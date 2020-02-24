# check https://github.com/balsoft/nixos-config

{ config, pkgs, ... }:

let
  # todo: extract to a separate file or environment vars
  nixpkgs = (builtins.fetchTarball
    (builtins.fromJSON (builtins.readFile ./nixpkgs.lock.json)));
  settings = (import ./settings.nix);
  colors = settings.colors;
in {

  imports = [
    ./i3/i3wm.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.services.xserver.dpi = 166;
  nixpkgs.config.fonts.fontconfig.dpi = 167;
  # nixpkgs.config.size = 150;

  programs = {
    home-manager.enable = true;

    rofi = {
      enable = true;
      theme = "${./rofi/themes/material.rasi}";
    };

    termite = {
      enable = true;
      # font = "${font} 11";
      backgroundColor = "rgba(32, 39, 51, 0.3)";
      dynamicTitle = true;
      clickableUrl = true;
    };

    # vscodium-with-extensions = {
    #   enable = true;
    # };
  };

  xsession = {
    enable = true;

    pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 150;
    };

    # windowManager.sway = rec {
    #   enable = true;
    # };

    # windowManager.i3 = import ./i3/i3wm.nix {
    #   mod = config.modifier;
    #   pkgs = pkgs;
    # };
  };

  home.file = {
    ".config/sway" = {
      source = ./sway;
      recursive = true;
    };

    ".config/waybar" = {
      source = ./waybar;
      recursive = true;
    };

    ".config/i3/status.toml".source = ./i3/i3status-rust.toml;
  };

  home.file.".config/kitty/kitty.conf".text = ''
    background ${colors.grey-dark}
    background_opacity 0.8
    font_size 11.0
    input_delay 0
  '';
  fonts.fontconfig.enable = true;

  home = {
    stateVersion = "19.09";

    # this fixes a locales bug when using nix as a package manager.
    # sessionVariables.LOCALE_ARCHIVE =
    #   "${pkgs.glibcLocales}/lib/locale/locale-archive";

    # packages = import ./packages.nix { pkgs = pkgs; };

    packages = with pkgs; [
      #cli
      htop # performance monitor
      ranger # file manager
      # hunter # rust based file manager
      vifm # vim file manager
      broot # awesome file manager, sorter, finder
      fzf # fuzzy finder and launcher
      jq # jquery cli parser
      youtube-dl # video downloader
      bat # cat with syntax highlighting
      dust # du replacement
      ripgrep # fast rust grepping tool
      megatools # mega.nz cli tools

      # disks
      parted # disk partitioning
      partimage # image cloning
      # bashmount # removable disk mount/unmount https://github.com/jamielinux/bashmount
      # diskrsync
      # diskscan # scan disks for errors

      # web services
      googler # google cli
      haxor-news # hacker news cli
      rtv # reddit cli

      # terminals
      # terminator
      # termite
      alacritty
      kitty

      # crypto
      # wasabiwallet

      # ide
      vscodium
      nixfmt
      sublime3
      sublime-merge

      # i3
      # i3
      # i3status-rust
      rofi
      waybar
      # wofi grim wl-clipboard imv slurp brightnessctl bemenu

      # browsers
      brave
      chromium
      vivaldi-ffmpeg-codecs
      firefox-wayland

      # chat
      signal-desktop
      tdesktop # telegram

      # sound
      pulsemixer

      # video
      mpv

      # file management
      xfce.thunar

      # dirty hax
      glibcLocales

      # gtk themes
      hicolor-icon-theme # required by wofi
    ];
  };
}
