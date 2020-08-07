with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "hunter";
  buildInputs = [ makeWrapper ];
  buildPhase = "true";
  unpackPhase = "true";

  installPhase = ''
    codium --install-extension ./codelldb-x86_64-linux.vsix

  '';
}

# file ./codelldb
# patchelf --set-interpreter /nix/store/c2rlh7xa8fcgg7qz8pl76ipvvb172c6k-glibc-2.30/lib/ld-linux-x86-64.so.2 ./codelldb
