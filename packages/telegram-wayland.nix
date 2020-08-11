# not working :()

with import <nixpkgs> { };
with lib;
stdenv.mkDerivation rec {
  name = "telegram-wayland";
  src = (builtins.fetchurl
    "https://github.com/telegramdesktop/tdesktop/releases/download/v2.2.0/tsetup.2.2.0.tar.xz");

  # nativeBuildInputs = [ pkgconfig cmake ninja python3 ];
  nativeBuildInputs = [ unzip autoPatchelfHook ];
  buildInputs = [
    qt5.qtbase libsForQt5.libdbusmenu
    xorg.libxcb xorg.libX11 libGL fontconfig libdrm xorg.libICE freetype glib xorg.libSM
  ];

  QT_QPA_PLATFORM = "wayland";
  #QT_XKB_CONFIG_ROOT = "${xorg.libX11}/lib";

  installPhase = ''
    mkdir -p $out/bin
    find .
    cp ./Telegram $out/bin/telegram-wayland
    chmod +x $out/bin/telegram-wayland
  '';
}
