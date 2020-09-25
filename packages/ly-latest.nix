# { stdenv, lib, fetchFromGitHub, linux-pam }:
with import <nixpkgs> {};

stdenv.mkDerivation rec { 
  pname = "ly";
  version = "0.5.2";

  src = fetchFromGitHub {
    owner = "nullgemm";
    repo = "ly";
    rev = "v0.3.0";
    sha256 = "0g3c70f6jyjqygya86rdaq6vfyy9ck3rlzlcpi03nmfiigl5camz";
    fetchSubmodules = true;
  }; 

  buildInputs = [ linux-pam ];
  makeFlags = [ "FLAGS=-Wno-error" ];

  installPhase = ''
    mkdir -p $out/bin
    cp bin/ly $out/bin 
  '';

  meta = with lib; {
    description = "TUI display manager";
    license = licenses.wtfpl;
    homepage = https://github.com/nullgemm/ly;
    maintainers = [ maintainers.spacekookie ];
  };
}
