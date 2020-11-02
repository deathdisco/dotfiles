{ config, pkgs, ... }:

let
  #sway_config = (import ./sway-config.nix);
  settings = (import ../../settings.nix);
  colors = {
    black = "#000000";
    white = "#FFFFFF";
    pink = "#FC0394";
    red = "#900000";
    grey-dark = "#111111";
    grey-medium = "#888888";
    grey-light = "#d8dee8";
    sea-blue = "rgb(82, 157, 242)";
    neon-green = "rgb(60, 255, 136)";
  };
in {

  home.packages = with pkgs; [
    grim # screenshot util
    i3status-rust # status bar
    imv # image viewer for wayland
    kanshi
    mako
    wofi
    # redshift # color temperature
    slurp
    swaybg # desktop background https://github.com/swaywm/swaybg
    swayidle
    swaylock # lock screen
    wl-clipboard # cut copy paste support
    xwayland # compatibility layer for x11 apps
    bemenu
  ];

  home.file.".config/sway/config".text = (import ./sway-config.nix { pkgs = pkgs; settings = settings; });
  home.file.".config/sway/i3status-rust.toml".source = ./i3status-rust.toml;
}
