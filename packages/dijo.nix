with import <nixpkgs> {};

rustPlatform.buildRustPackage rec {
  pname = "dijo";
  version = "9102dc72be19f87ec9e2893a35f5020957135c1c";

  src = fetchFromGitHub {
    owner = "NerdyPepper";
    repo = pname;
    rev = version;
    sha256 = "1ch320j2d66zn9mbs7xl0bkfcm2hpak6izk0yspz1gcji1l7grsc";
  };

  cargoSha256 = "1ylfkihq7x00z22hwbjkidisaklb3w5iqij9s916mgz993saq4pi";
  verifyCargoDeps = true;

  meta = with stdenv.lib; {
    description = "scriptable, curses-based, digital habit tracker";
    homepage = https://github.com/NerdyPepper/dijo;
    license = licenses.mit;
    platforms = platforms.all;
  };
}
