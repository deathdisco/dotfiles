{ config, lib, pkgs, ... }:
let
  rev =
    "master"; # could be a git rev, to pin the overlay (not usually recommended)
  waylandOverlay = (import (builtins.fetchTarball {
    src =
      "https://github.com/colemickens/nixpkgs-wayland/archive/${rev}.tar.gz";
    sha256 = "1iq6fy50pv36zsd3qxbyjs3rn1x2541v8z74kcd3n0hqs6406xni";
  }));
in {
  nixpkgs.overlays = [ waylandOverlay ];
  home.packages = with pkgs; [ chromium ];
  # ...
}
