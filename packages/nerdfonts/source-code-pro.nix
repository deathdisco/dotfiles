{ stdenv, fetchzip, ... }:

stdenv.mkDerivation rec {
  name = "source-code-pro-nerdfonts";
  version = "2.1.0";

  src = fetchzip {
    url =
      "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/SourceCodePro.zip";
    sha256 = "116s7md53lql8wd08wcld64yq1z4ighkld4p3pl4z72xhvxwmbnf";
    stripRoot = false;
  };
  buildCommand = ''
    install --target $out/share/fonts/opentype -D $src/*.ttf
  '';

  meta = with stdenv.lib; {
    description = "Nerdfont version of Source Code Pro";
    homepage = "https://github.com/ryanoasis/nerd-fonts";
    license = licenses.mit;
  };
}
