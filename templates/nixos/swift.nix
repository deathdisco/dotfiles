# { nixpkgs ? import <nixpkgs> { } }:

# let pkgs = [ nixpkgs.swift nixpkgs.gcc ];

# in nixpkgs.stdenv.mkDerivation {
#   name = "env";
#   buildInputs = pkgs;
# }

{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  name = "swift-env";

  buildInputs = with pkgs; [
    swift
    pkgconfig
    openssl
    zlib
    # stdenv
    # binutils
    # cmake
    # curl
    # glibc
    # icu
    # libblocksruntime
    # libbsd
    # libedit
    # libuuid
    # libxml2
    # sqlite
    # swig
  ];

  dontPathELF = true;

  shellHook = ''
    CC=clang
  '';
}
