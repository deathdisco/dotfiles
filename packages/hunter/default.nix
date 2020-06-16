with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "hunter";
  buildInputs = [ makeWrapper ];
  buildPhase = "true";
  # libPath = lib.makeLibraryPath with xlibs;[ libXrandr libXinerama libXcursor ];
  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out/bin
    cp ${./hunter} $out/bin/hunter
    chmod +x $out/bin/hunter
  '';
}

# with import <nixpkgs> {};
# stdenv.mkDerivation {
#   name = "hunter";
#   src = ./v1.3.5.tar.gz;
# }
