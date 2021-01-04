{ pkgs, ... }:
let
  emacs-overlay = import (builtins.fetchTarball {
    url =
      "https://github.com/mjlbach/emacs-pgtk-nativecomp-overlay/archive/master.tar.gz";
    sha256 = "1iq6fy50pv36zsd3qxbyjs3rn1x2541v8z74kcd3n0hqs6406xni";
  });
in {
  pkgs.overlays = [ emacs-overlay ];
  home.packages = [ pkgs.emacsGccPgtk ];
  # home.file.".emacs.d/init.el".text = ''
  #     (load "default.el")
  # '';
}
