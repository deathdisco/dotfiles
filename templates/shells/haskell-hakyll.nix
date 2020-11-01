{ nixpkgs ? import <nixpkgs> { } }:
with (import (fetchTarball https://github.com/nixos/nixpkgs/archive/bac4d95aa2a92be7049dedafb8ec76606f79d8a2.tar.gz) {});
mkShell {
  name = "shell";
  buildInputs = [
    ghc cabal-install zlib
    # haskellPackages.ghcWithPackages (pkgs: with pkgs; [hakyll])
    pkgs.haskellPackages.hakyll
  ];
}
