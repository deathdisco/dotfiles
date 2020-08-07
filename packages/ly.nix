with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "ly";
  src = (builtins.fetchurl
    "https://github.com/cylgom/ly/releases/download/v0.5.0/ly_0.5.0.zip");

  nativeBuildInputs = [ unzip autoPatchelfHook ];
  buildInputs = [ pam xorg.libxcb ];

  installPhase = ''
    mkdir -p $out/bin
    find .
    cp ./bin/ly $out/bin/ly
    chmod +x $out/bin/ly
  '';
}
