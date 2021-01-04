{ pkgs, lib, ... }:

let
  moz_overlay = import (builtins.fetchTarball {
    src = "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";
    sha256 = "0iq6fy50pv36zsd3qxbyjs3rn1x2541v8z74kcd3n0hqs6406xni";
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
