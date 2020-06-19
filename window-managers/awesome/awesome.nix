{ config, pkgs, ... }:

let

in {
  # xsession.windowManager.awesome = {
  #   enable = true;
  # };

  # NEEDS PACKAGE: acpi, xfce4-power-manager-settings

  home.file = {
    ".config/awesome" = {
      source = ./config;
      recursive = true;
    };
  };
}
