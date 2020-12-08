{ nixpkgs ? import <nixpkgs> { } }:
let
  moz_overlay = import (builtins.fetchTarball
    "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz");
  sha256 = "0jq6fy50pv36zsd3qxbyjs3rn1x2541v8z74kcd3n0hqs6406xni";
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
in with nixpkgs;
stdenv.mkDerivation {
  name = "servo-shell-env";
  buildInputs = [
    nixpkgs.latest.rustChannels.nightly.rust
    cargo
    clang
    openssl
    pkgconfig
    vulkan-validation-layers
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xlibs.libXrandr
    freetype
    expat
    fontconfig
    libGL
  ];

  APPEND_LIBRARY_PATH = stdenv.lib.makeLibraryPath [
    vulkan-loader
    xlibs.libXcursor
    xlibs.libXi
    xlibs.libXrandr
    freetype
    expat
    fontconfig
    libGL
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$APPEND_LIBRARY_PATH"
    export RUSTFLAGS="-C target-cpu=native"
  '';
}
