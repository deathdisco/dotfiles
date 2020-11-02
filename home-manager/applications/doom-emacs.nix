{ pkgs, ... }:
let
	# nixpkgs.overlays = [import (builtins.fetchTarball {
 #      url = https://github.com/mjlbach/emacs-pgtk-nativecomp-overlay/archive/master.tar.gz;
 #    })];

	emacs-overlay = import (builtins.fetchTarball {
		      url = https://github.com/mjlbach/emacs-pgtk-nativecomp-overlay/archive/master.tar.gz;
		    });
in {
	pkgs.overlays = [ emacs-overlay ];
 home.packages = [ pkgs.emacsGccPgtk ];
 # home.file.".emacs.d/init.el".text = ''
 #     (load "default.el")
 # '';
}
