{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  name = "steamrun-env";

  buildInputs = with pkgs; [
    steam-run
  ];

  shellHook = ''
    CC=clang
  '';
}
