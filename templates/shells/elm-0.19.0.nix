{ nixpkgs ? import <nixpkgs> { } }:

# pin to elm-0.19.0
with (import (fetchTarball {
  src =
    "https://github.com/nixos/nixpkgs/archive/bac4d95aa2a92be7049dedafb8ec76606f79d8a2.tar.gz";
  sha256 = "1iq6fy50pv36zsd3qxbyjs3rn1x2541v8z74kcd3n0hqs6406xni";
}) { });

mkShell {
  name = "elm-env";

  buildInputs = with pkgs; [ elmPackages.elm elmPackages.elm-format ];

  APPEND_LIBRARY_PATH = stdenv.lib.makeLibraryPath [ ];

  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$APPEND_LIBRARY_PATH"
  '';
}
