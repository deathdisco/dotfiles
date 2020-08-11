{ nixpkgs ? import <nixpkgs> { } }:

with nixpkgs;

mkShell {
  name = "elm-env";

  buildInputs = with pkgs; [
    elmPackages.elm
    elmPackages.elm-format
  ];

  APPEND_LIBRARY_PATH = stdenv.lib.makeLibraryPath [
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$APPEND_LIBRARY_PATH"
  '';
}
