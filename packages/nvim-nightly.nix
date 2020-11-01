{ pkgs ? import <nixpkgs> { } }:

with pkgs;

stdenv.mkDerivation rec {
  name = "neovim-nightly";
  meta.priority = 0;

  src = (builtins.fetchurl
    "https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz");

  nativeBuildInputs = [ unzip autoPatchelfHook ];
  buildInputs = [ nodejs ];
  propagatedBuildInputs = [ nodejs ];

  installPhase = ''
    mkdir $out
    cp -r ./* $out/
    chmod +x $out/bin/nvim
  '';
}
