# https://github.com/bugnano/rnr
# not working

with import <nixpkgs> { };

let
  py = pkgs.python37;

  fuzzyfinder = py.pkgs.buildPythonPackage rec {
    name = "fuzzyfinder-1.0.0";

    src = pkgs.fetchurl {
      url =
        "https://pypi.python.org/packages/source/f/fuzzyfinder/fuzzyfinder-1.0.0.tar.gz";
      sha256 = "11w0kha42a9kya4rv6amrhdhh4m26kzxrvg43mm3c7wiz3i4h7k9";
    };

    meta = with lib; {
      description = "Fuzzy Finder implemented in Python.";
      homepage = "https://github.com/amjith/fuzzyfinder";
      license = licenses.bsd3;
      platforms = platforms.unix;
    };
  };

  rnr-pkg = py.pkgs.buildPythonPackage rec {
    pname = "rnr";
    version = "0.4.1";

    src = py.pkgs.fetchPypi {
      inherit pname;
      inherit version;
      sha256 = "051gxjbknqjvvy6da77z20046h6k1d316blzdbz4kh3im7x97ny8";
    };

    nativeBuildInputs = [
      asciidoc
      fuzzyfinder
      python3
      python3Packages.urwid
      python3Packages.pyxdg
      python3Packages.atomicwrites
      python3Packages.pygments
      python3Packages.shutilwhich
    ];

    propagatedBuildInputs = [
      asciidoc
      fuzzyfinder
      python3
      python3Packages.urwid
      python3Packages.pyxdg
      python3Packages.atomicwrites
      python3Packages.pygments
      python3Packages.shutilwhich
    ];

    # The package has no tests
    doCheck = false;

    meta = with lib; {
      description = "A simple Python wrapper around rnr";
      homepage = "https://github.com/bugnano/rnr";
      license = licenses.mit;
    };
  };

  # rnr = pkgs.python3Packages.callPackage rnr-pkg { };

in stdenv.mkDerivation rec {
  name = "rnr";
  version = "0.4.1";
  src = rnr-pkg;
  # buildInputs = [
  #   asciidoc
  #   fuzzyfinder
  #   python3Packages.urwid
  #   python3Packages.pyxdg
  #   python3Packages.atomicwrites
  #   python3Packages.pygments
  # ];
  installPhase = ''
    find .
    mkdir -p $out/bin
    cp -r ./bin/* $out/bin/
    chmod +x $out/bin/rnr
  '';
}
