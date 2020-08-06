{ nixpkgs ? import <nixpkgs> { } }:

with nixpkgs;

mkShell {
  name = "typescript-env";

  buildInputs = with pkgs; [
    webkitgtk
    gtk3
    glib
  ];

  APPEND_LIBRARY_PATH = stdenv.lib.makeLibraryPath [
    webkitgtk
    gtk3
    glib
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$APPEND_LIBRARY_PATH"
  '';
}
