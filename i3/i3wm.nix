{ config, pkgs, ... }:

let
	settings = (import ../settings.nix);
	colors = settings.colors;
	
in {
	programs = {
		rofi = {
			enable = true;
			font = "Source Code Pro 18";
			padding = 20;
			colors = {
				window = {
					background = "#00000060";
					border = "argb:582a373e";
					separator = "#CCC";
				};
				rows = {
					normal = {
					  background = "#00000060";
					  foreground = "#fafbfc";
					  backgroundAlt = "#00000060";
					  highlight = {
					    background = "#00bcd4";
					    foreground = "#fafbfc";
					  };
				};
				};
			};
		};
	};
	home.packages = with pkgs; [
		feh # image viewer, also for desktop wallpaper
		flameshot # image capture x11 only
	];
	# home.file = {
	# 	".config/rofi/themes.toml".source = ./i3/i3status-rust.toml;
	# };
	xsession = {
	    enable = true;

	    windowManager.i3 = {
              enable = true;
              package = pkgs.i3-gaps;
	      config = {
			modifier = "Mod1";
			modes = { };

	        startup = [
	          { command = "${pkgs.feh}/bin/feh --bg-fill ${settings.wallpaper}";
	            always = true;
	            notification = false;
	          }
	        ];

			bars = [{
			  mode = "dock";
			  position = "top";
			  statusCommand =
			    "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";

			  extraConfig = ''
			    binding_mode_indicator yes
			  '';

			  colors = {
			    background = "${colors.black}";
			    focusedWorkspace = {
			      background = "${colors.pink}";
			      border = "${colors.pink}";
			      text = "${colors.white}";
			    };
			    activeWorkspace = {
			      background = "${colors.black}";
			      border = "${colors.black}";
			      text = "${colors.grey-light}";
			    };
			    inactiveWorkspace = {
			      background = "${colors.black}";
			      border = "${colors.black}";
			      text = "${colors.grey-light}";
			    };
			    urgentWorkspace = {
			      background = "${colors.red}";
			      border = "${colors.red}";
			      text = "${colors.black}";
			    };
			    # binding mode is when workspaces have different keybindings
			    bindingMode = {
			      background = "${colors.black}";
			      border = "${colors.black}";
			      text = "${colors.pink}";
			    };
			  };
			}];

			window.border = 0;
			# window.hideEdgeBorders = "smart";
			floating.border = 0;

			colors = {
			  background = "${colors.black}";
			  focused = {
			    border = "${colors.black}";
			    background = "${colors.black}";
			    text = "${colors.pink}";
			    indicator = "${colors.grey-medium}";
			    childBorder = "${colors.grey-medium}";
			  };
			  focusedInactive = {
			    border = "${colors.black}";
			    background = "${colors.black}";
			    text = "${colors.grey-light}";
			    indicator = "${colors.black}";
			    childBorder = "${colors.black}";
			  };
			  unfocused = {
			    border = "${colors.black}";
			    background = "${colors.black}";
			    text = "${colors.grey-medium}";
			    indicator = "${colors.black}";
			    childBorder = "${colors.black}";
			  };
			  urgent = {
			    border = "${colors.red}";
			    background = "${colors.red}";
			    text = "${colors.grey-light}";
			    indicator = "${colors.black}";
			    childBorder = "${colors.black}";
			  };
			  placeholder = {
			    border = "${colors.grey-dark}";
			    background = "${colors.grey-dark}";
			    text = "${colors.grey-light}";
			    indicator = "${colors.black}";
			    childBorder = "${colors.black}";
			  };
			};

			keybindings = import ./keybindings.nix {
			  mod = "Mod1";
			  pkgs = pkgs;
			};
			};

			extraConfig = ''
			default_orientation vertical
			workspace_layout stacking
			'';
		};
	};
}
