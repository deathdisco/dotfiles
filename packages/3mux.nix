with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "3mux";
  src = (builtins.fetchurl
    "https://github.com/aaronjanse/3mux/releases/download/v1.0.1/3mux-v1.0.1-linux-amd64.tar.gz");

  nativeBuildInputs = [ unzip autoPatchelfHook ];

  unpackPhase = ''
    tar xf $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    echo "ok" $PWD
    find .
    cp ./3mux $out/bin/3mux
    chmod +x $out/bin/3mux
  '';
}
