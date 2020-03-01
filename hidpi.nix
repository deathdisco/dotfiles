{ config, pkgs, ... }:

let
	settings = (import ../settings.nix);
	colors = settings.colors;
	
in {





  nixpkgs.config = {

  	# none of this seems to work. investigate further.
  	xresources.properties = {
  		"Xcursor.theme" = "Adwaita";
  		"Xcursor.size" = "64";
  	};

  	services.xserver.dpi = 166;
  	services.xserver.displayManager.sessionCommands = ''
	  ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
	    Xcursor.theme: Adwaita
	    Xcursor.size: 64
	  EOF
	'';
  };
  nixpkgs.config.fonts.fontconfig.dpi = 167;
  # nixpkgs.config.size = 150;
  
  nixpkgs.config.environment.variables = {
    GDK_DPI_SCALE = "1.5";
    GDK_SCALE = "1.5";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1.5";
    XCURSOR_SIZE = "64";
  };
}
