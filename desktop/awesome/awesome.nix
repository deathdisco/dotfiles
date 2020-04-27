{ config, pkgs, ... }:

let

in {
  # xsession.windowManager.awesome = {
  #   enable = true;
  # };

  home.file = {
    ".config/awesome" = {
      source = ./config;
      recursive = true;
    };
  };
}
