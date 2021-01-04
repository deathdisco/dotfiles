{ pkgs, lib, ... }:

let
  moz_overlay = import (builtins.fetchTarball {
    url = "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";
    sha256 = "1zybp62zz0h077zm2zmqs2wcg3whg6jqaah9hcl1gv4x8af4zhs6";
  });

  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
  #rustNightlyChannel = (nixpkgs.rustChannelOf { date = "2019-01-26"; channel = "nightly"; }).rust;
  rustStableChannel = nixpkgs.latest.rustChannels.stable.rust.override {
    extensions =
      [ "rust-src" "rls-preview" "clippy-preview" "rustfmt-preview" ];
  };
  # in with nixpkgs;
  # stdenv.mkDerivation {
  #   name = "moz_overlay_shell";
  #   buildInputs = [ rustStableChannel rls rustup ];
  # }

in { home.packages = with pkgs; [ rustStableChannel gcc ]; }
