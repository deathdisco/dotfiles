{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    alsaLib
    cmake
    freetype
    openssl
    pkgconfig
    xlibs.libX11
    libxkbcommon
    wayland
  ];

  APPEND_LIBRARY_PATH = with pkgs;
    stdenv.lib.makeLibraryPath [ wayland xlibs.libXcursor xlibs.libXi xlibs.libXrandr libxkbcommon ];

  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$APPEND_LIBRARY_PATH"
    export RUSTFLAGS="-C target-cpu=native"
  '';

}

