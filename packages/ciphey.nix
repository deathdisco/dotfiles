with import <nixpkgs> { };

let
  py = pkgs.python38;

  ciphey-pkg = py.pkgs.buildPythonPackage rec {
    pname = "ciphey";
    version = "5.9.0";

    src = py.pkgs.fetchPypi {
      inherit pname;
      inherit version;
      sha256 = "0v8dznawjyhmhjxz2qwnsf60mp0b3z4flzzfd27z6mlwxfxzpjz0";
    };

    nativeBuildInputs = [
      python3
      python38Packages.setuptools
      python38Packages.click
      python38Packages.pyyaml
      python38Packages.clickSpinner
    ];

    propagatedBuildInputs = [
      python3
      python38Packages.setuptools
      python38Packages.click
      python38Packages.pyyaml
    ];

    # The package has no tests
    doCheck = false;

    meta = with lib; {
      description = "A simple Python wrapper around ciphey";
      homepage = "https://github.com/ciphey";
      license = licenses.mit;
    };
  };

in stdenv.mkDerivation rec {
  name = "ciphey";
  version = "0.4.1";
  src = ciphey-pkg;
  installPhase = ''
    find .
    mkdir -p $out/bin
    cp -r ./bin/* $out/bin/
    chmod +x $out/bin/ciphey
  '';
}
