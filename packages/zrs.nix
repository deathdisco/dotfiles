with import <nixpkgs> {};

rustPlatform.buildRustPackage rec {
  pname = "zrs";
  version = "69dd20341ea3b387b9984329adc160960b75ace1";

  src = fetchFromGitHub {
    owner = "fauxfaux";
    repo = pname;
    rev = version;
    sha256 = "0vy79i0svp9ilycvhcnfz2gvrh8p39ngadan8vciv2p1c0i5jm1l";
  };

  cargoSha256 = "062ba1cy4rxwf238zl71cc43xx70z6hjip6s0r584zgr5v3fml4v";
  verifyCargoDeps = true;

  meta = with stdenv.lib; {
    description = "faster 'z': jump to frecently used directories";
    homepage = https://github.com/FauxFaux/zrs;
    license = licenses.mit;
    platforms = platforms.all;
  };
}
