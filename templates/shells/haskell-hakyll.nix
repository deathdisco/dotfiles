{ nixpkgs ? import <nixpkgs> { } }:
with (import (fetchTarball {
  src =
    "https://github.com/nixos/nixpkgs/archive/bac4d95aa2a92be7049dedafb8ec76606f79d8a2.tar.gz";
  sha256 = "1iq6fy50pv36zsd3qxbyjs3rn1x2541v8z74kcd3n0hqs6406xni";
}) { });
mkShell {
  name = "shell";
  buildInputs = [
    ghc
    cabal-install
    zlib
    # haskellPackages.ghcWithPackages (pkgs: with pkgs; [hakyll])
    pkgs.haskellPackages.hakyll
  ];
}
