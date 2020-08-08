{ config, lib, pkgs, ... }:
let
  rev =
    "master"; # could be a git rev, to pin the overlay (not usually recommended)
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/${rev}.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball url));
in {
  nixpkgs.overlays = [ waylandOverlay ];
  home.packages = with pkgs; [ chromium ];
  # ...
}
