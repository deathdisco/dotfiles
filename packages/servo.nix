with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "servo";
  src = (builtins.fetchurl
    "https://download.servo.org/nightly/linux/servo-latest.tar.gz");

  nativeBuildInputs = [ unzip autoPatchelfHook ];

  buildInputs = [
    xlibs.libXcursor
    xlibs.libXi
    xlibs.libXrandr
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-bad
    openssl
    freetype
    dbus
    fontconfig
    libunwind
  ];

  # libPath = with xlibs;
  #   stdenv.lib.makeLibraryPath [ libXrandr libXinerama libXcursor ];

  APPEND_LIBRARY_PATH = stdenv.lib.makeLibraryPath [
    xlibs.libXcursor
    xlibs.libXi
    xlibs.libXrandr
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-bad
    openssl
    freetype
    dbus
    fontconfig
    libunwind
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./* $out/bin/
    chmod +x $out/bin/servo
  '';

  # postFixup = ''
  #   patchelf \
  #     --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
  #     --set-rpath "${libPath}" \
  #     $out/bin/servo
  # '';
}
