{ pkgs ? import <nixpkgs> { } }:

let
  # esypkg = (pkgs.callPackage ./esy {});
  esy = pkgs.callPackage ./esy {

  };

in pkgs.stdenv.mkDerivation rec {
  name = "onivim";
  version = "0.4.1";
  src = (builtins.fetchurl "https://github.com/onivim/oni2/archive/master.zip");

  # src = fetchFromGitHub {
  #   owner = "onivim";
  #   repo = "oni2";
  #   rev = "28e55c7ab77e9d629ad7698f73c1a90c88444c1a";
  #   sha256 = "01h991i5zxx7j2yb71qgdqz5nq9c51v6zdr1p0pmrx6gc23l9m4g";
  # };

  nativeBuildInputs = with pkgs; [ unzip autoPatchelfHook ];
  buildInputs = with pkgs; [ nodejs esy ];

  unpackPhase = ''
  '';

  installPhase = ''
  esy install
  '';
}
