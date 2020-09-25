{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "rust-env";

  buildInputs = with pkgs; [
    rustup
    clang
    openssl
    pkgconfig
  ];

  shellHook = ''
  '';
}
