{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    alsaLib
    cargo
    cmake
    glfw
    libGL
    pkgconfig
    rustc
    rustfmt
    shaderc
    vulkan-loader
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXi
    xorg.libXinerama
    xorg.libXrandr
  ];

  LD_LIBRARY_PATH = "${pkgs.vulkan-loader}/lib:${pkgs.xorg.libX11}/lib:${pkgs.xorg.libXcursor}/lib:${pkgs.xorg.libXi}/lib:${pkgs.xorg.libXrandr}/lib:${pkgs.libGL}/lib:$LD_LIBRARY_PATH";
  ALSA_LIB_DEV = "${pkgs.alsaLib.dev}"; #
  SHADERC_LIB_DIR = "${pkgs.shaderc}/lib";
}
