let
   pkgs = import <nixpkgs> {};
in with pkgs; stdenv.mkDerivation rec {
  name = "servo-env";
  buildInputs = with xlibs; [
    # Native dependencies
    freetype mesa expat openssl x11 libXxf86vm libXmu

    # Build utilities
    cmake dbus gcc git pkgconfig which
  ] ++ (with python27Packages; [virtualenv pip dbus]);

  # Allow cargo to download crates
  SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";

  # Runtime dependencies
  LD_LIBRARY_PATH = with xlibs; stdenv.lib.makeLibraryPath [
    mesa zlib libX11 libXcursor libXxf86vm libXi
  ];

  # Enable colored cargo and rustc output
  TERMINFO = "${ncurses.out}/share/terminfo";
}
