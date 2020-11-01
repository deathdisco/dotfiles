{ nixpkgs ? import <nixpkgs> { } }:

# pin to elm-0.19.0
with (import (fetchTarball https://github.com/nixos/nixpkgs/archive/bac4d95aa2a92be7049dedafb8ec76606f79d8a2.tar.gz) {});

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
