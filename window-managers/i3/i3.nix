{ config, pkgs, ... }:

let
  settings = (import ../../settings.nix);
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
  imports = [
    ../../applications/picom.nix
    ../../applications/polybar.nix
  ];

  # Enable the X11 windowing system.
  nixpkgs.config.services.xserver = { enable = true; };

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



  home.packages = with pkgs; [
    glibcLocales # for rofi
    feh # image viewer, also for desktop wallpaper
    flameshot # image capture x11 only
    xorg.xauth
    xorg.twm
    xorg.xmodmap
    xterm
    skippy-xd
    hack-font
    font-awesome
  ];

  # home.file = {
  # 	".config/rofi/themes.toml".source = ./i3/i3status-rust.toml;
  # };

  #xsession.pointerCursor = {
  #  package = pkgs.capitaine-cursors;
  #  name = "capitaine-cursors";
  #  size = 16;
  #};

  xsession = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = "Mod1";
        modes = { };

        startup = [{
          command = "${pkgs.feh}/bin/feh --bg-max --bg-fill ${settings.wallpaper}";
          always = true;
          notification = false;
        }];

        bars = [{
          mode = "dock";
          position = "bottom";
          statusCommand =
            "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";

          extraConfig = ''
            binding_mode_indicator yes
          '';

          colors = {
            background = "#FF401111";
            focusedWorkspace = {
              background = "${colors.pink}";
              border = "${colors.pink}";
              text = "${colors.white}";
            };
            activeWorkspace = {
              background = "${colors.white}";
              border = "${colors.white}";
              text = "${colors.black}";
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
              background = "${colors.pink}";
              border = "${colors.black}";
              text = "${colors.pink}";
            };
          };
        }];

        # window.border = 10;
        # window.hideEdgeBorders = "smart";
        floating.border = 1;

        colors = {
          background = "#FF401100";
          focused = {
            border = "${colors.black}";
            background = "${colors.black}";
            text = "${colors.white}";
            indicator = "${colors.black}";
            childBorder = "${colors.black}";
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

      # exec --no-startup-id "picom"

      extraConfig = ''
        exec --no-startup-id picom --config ~/.picom.conf
        default_orientation vertical
        default_border pixel 1
        focus_follows_mouse no
        workspace_layout tabbed
        for_window [class="[.]*"] floating enable
        exec xmodmap -e "clear lock" #disable caps lock switch
        exec xmodmap -e "keysym Caps_Lock = Escape" #set caps_lock as escape
        # xev -event keyboard
        bindcode Mod1+34 workspace prev
        bindcode Mod1+35 workspace next
      '';
    };
  };
}
