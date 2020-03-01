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
    ./hidpi.nix
    ./packages.nix
    ./i3/i3wm.nix
    ./package-sets/development.nix
  ];

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.services.xserver.dpi = 166;
  # nixpkgs.config.fonts.fontconfig.dpi = 167;
  # # nixpkgs.config.size = 150;
  
  # nixpkgs.config.environment.variables = {
  #   _JAVA_AWT_WM_NONREPARTENTING = "1";
  #   GDK_DPI_SCALE = "0.5";
  #   GDK_SCALE = "1.5";
  #   QT_AUTO_SCREEN_SCALE_FACTOR = "1.5";
  #   XCURSOR_SIZE = "32";
  # };

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

  # home.file.".icons/default".source = "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors"; 

  # xsession = {
  #   enable = true;

  #   pointerCursor = {
  #     name = "Capitaine";
  #     package = pkgs.capitaine-cursors;
  #     size = 96;
  #   };
  # };

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
    background_opacity 0.88
    font_size 11.0
    input_delay 0
  '';
  fonts.fontconfig.enable = true;

  home = {
    stateVersion = "19.09";
  };
}
