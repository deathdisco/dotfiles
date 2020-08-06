{ config, pkgs, ... }: {
	programs.sway = {
		enable = true;
		extraPackages = with pkgs; [
			grim # screenshot util
			i3status-rust # status bar
			imv # image viewer for wayland
			kanshi
			mako
			wofi
			# redshift # color temperature
			slurp
			swaybg # desktop background https://github.com/swaywm/swaybg
			swayidle
			swaylock # lock screen
			wl-clipboard # cut copy paste support
			xwayland # compatibility layer for x11 apps
		];
	};
}
