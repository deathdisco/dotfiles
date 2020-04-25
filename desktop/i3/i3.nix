{ config, pkgs, ... }:

let

  colors = {
    black = "#000000";
    white = "#FFFFFF";
    pink = "#FC0394";
    red = "#900000";
    grey-dark = "#111111";
    grey-medium = "#888888";
    grey-light = "#d8dee8";
    sea-blue = "rgb(82, 157, 242)";
    neon-green = "rgb(60, 255, 136)";
  };

in {

  # Enable the X11 windowing system.
  #	services.xserver = {
  #		enable = true;
  #
  #xsession.windowManager.i3 = {
  #  	enable = true;
  #  	extraPackages = with pkgs; [
  #	    dmenu #application launcher most people use
  #	    i3status # gives you the default i3 status bar
  #	    i3lock #default i3 screen locker
  #	    i3blocks #if you are planning on using i3blocks over i3status
  # 	];
  # };
  #	};
  # text only prompt, no display manager
  # xserver.displayManager.startx.enable = true;
  # LightDM
  # services.xserver.displayManager.lightdm.enable = true;
  # i3
  # config.services.xserver.windowManager.i3.enable = true;

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
    xorg.xauth
    xorg.twm
    xterm
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

        #startup = [
        #  { command = "${pkgs.feh}/bin/feh --bg-fill ${settings.wallpaper}";
        #    always = true;
        #    notification = false;
        #  }
        #];

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
