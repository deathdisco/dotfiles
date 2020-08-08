with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "servo";
  src = (builtins.fetchurl
    "https://download.servo.org/nightly/linux/servo-latest.tar.gz");

  nativeBuildInputs = [ unzip autoPatchelfHook ];
  buildInputs = [ ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./* $out/bin/
    chmod +x $out/bin/servo
  '';
}
