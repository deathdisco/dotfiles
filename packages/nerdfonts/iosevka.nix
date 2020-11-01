{ stdenv, fetchzip }:

stdenv.mkDerivation rec {
  name = "iosevka-nerdfonts-${version}";
  version = "2.1.0";

  src = fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/Iosevka.zip";
    sha256 = "1c4rz3qxvyns1sgv4p4pa7wdihaxq9n8hkjsnkygmwr6pylaj7lw";
    stripRoot = false;
  };
  buildCommand = ''
    install --target $out/share/fonts/opentype -D $src/*.ttf
  '';

  meta = with stdenv.lib; {
    description = "Nerdfont version of Iosevka";
    homepage = https://github.com/ryanoasis/nerd-fonts;
    license = licenses.mit;
  };
}