{ nixpkgs ? import <nixpkgs> { } }:

with nixpkgs;

mkShell {
  name = "typescript-env";

  buildInputs = with pkgs; [
    pkgconfig cmake
  ];

  APPEND_LIBRARY_PATH = stdenv.lib.makeLibraryPath [
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$APPEND_LIBRARY_PATH"
  '';
}
