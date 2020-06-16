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

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };
    extraConfig =
    let
      white = "#ECEFF4";
      gray = "#65737E";
      black = "#232423";
      blue = "#88C0D0";
      yellow = "#EBCB8B";
      orange = "#D08770";
      red = "#BF616A";
      green = "#A3BE8C";
      magenta = "#B48EAD";
      background = "#802E3440";

      overpass = "Overpass Mono:pixelsize=9;2";
      monofur = "Monofur Nerd Font:pixelsize=9;2";
    in
    # inspired by /ossix/dotfiles/dark-forest
    ''
    [global/wm]
    margin-top = 0
    margin-bottom = 0

    # Settings
    [settings]
    screenchange-reload = true

    #
    # Bars
    #

    [bar/top]
    dpi = 192
    radius = 0.0
    fixed-center = true
    bottom = false
    height = 40
    padding-left = 3
    padding-right = 4
    background = ${background}
    foreground = ${white}
    module-margin = 1
    underline-size = 1
    border-bottom-size = 0
    border-color = ${black}
    separator = " "

    font-0 = "FuraCode Nerd Font:style=Bold:size=8;2"
    font-1 = Font Awesome 5 Free:style=Regular:pixelsize=9;2
    font-2 = Font Awesome 5 Free:style=Solid:pixelsize=9;2
    font-3 = Font Awesome 5 Brands:pixelsize=9;2
    font-4 = "FuraCode Nerd Font:style=Bold:size=8;2"
    font-5 = FontAwesome:size=8;2
    font-6 = fontawesome:size=9;2

    enable-ipc = true

    modules-right = cpu memory battery volume
    modules-center = date
    modules-left = i3 xwindow

    #
    # Modules
    #

    [module/cpu]
    type = internal/cpu
    interval = 0.5

    format-prefix = 
    format = <label>

    label = %{A1:termite --exec=htop & disown:}%percentage:3%%%{A}

    ramp-coreload-0 = ▁
    ramp-coreload-1 = ▂
    ramp-coreload-2 = ▃
    ramp-coreload-3 = ▄
    ramp-coreload-4 = ▅
    ramp-coreload-5 = ▆
    ramp-coreload-6 = ▇
    ramp-coreload-7 = █
    ramp-coreload-0-foreground = ${gray}
    ramp-coreload-1-foreground = ${green}
    ramp-coreload-2-foreground = ${green}
    ramp-coreload-3-foreground = ${yellow}
    ramp-coreload-4-foreground = ${yellow}
    ramp-coreload-5-foreground = ${orange}
    ramp-coreload-6-foreground = ${orange}
    ramp-coreload-7-foreground = ${red}


    [module/memory]
    type = internal/memory
    interval = 0.2
    format-prefix = 
    format = <label>
    label = %{A1:termite --exec=htop & disown:}%percentage_used:3%%%{A}

    ramp-used-0 = ▁
    ramp-used-1 = ▂
    ramp-used-2 = ▃
    ramp-used-3 = ▄
    ramp-used-4 = ▅
    ramp-used-5 = ▆
    ramp-used-6 = ▇
    ramp-used-7 = █
    ramp-used-0-foreground = ${gray}
    ramp-used-1-foreground = ${green}
    ramp-used-2-foreground = ${green}
    ramp-used-3-foreground = ${yellow}
    ramp-used-4-foreground = ${yellow}
    ramp-used-5-foreground = ${orange}
    ramp-used-6-foreground = ${orange}
    ramp-used-7-foreground = ${red}


    [module/battery]
    type = internal/battery
    battery = BAT0
    adapter = ADP1
    full-at = 100
    interval = 1

    format-charging-prefix = 
    format-charging = <label-charging>
    label-charging = %percentage:3%%

    format-discharging = <ramp-capacity><label-discharging>
    label-discharging = %percentage:3%%

    format-full-prefix = 
    format-full = <label-full>
    label-full = %percentage:3%%

    ramp-capacity-0 = 
    ramp-capacity-0-font = 7
    ramp-capacity-1 = 
    ramp-capacity-1-font = 7
    ramp-capacity-2 = 
    ramp-capacity-2-font = 7
    ramp-capacity-3 = 
    ramp-capacity-3-font = 7
    ramp-capacity-4 = 
    ramp-capacity-4-font = 7
    ramp-capacity-0-foreground = ${red}
    ramp-capacity-1-foreground = ${orange}
    ramp-capacity-2-foreground = ${yellow}
    ramp-capacity-foreground = ${white}


    [module/volume]
    type = internal/pulseaudio
    format-volume = <ramp-volume><label-volume>
    label-volume = %percentage:3%%
    label-volume-foreground = ${white}

    format-muted-prefix = 
    format-muted-foreground = ${gray}
    label-muted = %percentage:3%%

    ramp-volume-0 = 
    ramp-volume-1 = 
    ramp-volume-2 = 
    ramp-volume-3 = 

    [module/date]
    type = internal/date
    date-alt = "%a - %m/%d"
    date = "%{T5}%I:%M%{T-}"
    interval = 1
    format-padding = 1

    [module/i3]
    type = internal/i3
    format = <label-state>
    index-sort = true
    wrapping-scroll = false
    format-padding-right = 1

    label-focused = %name%
    label-focused-foreground = ${white}
    label-focused-overline  = ${black}
    label-focused-padding = 2
    label-focused-font = 5

    label-unfocused = %name%
    label-unfocused-padding = 1
    label-unfocused-foreground = ${black}
    label-unfocused-overline = ${background}

    label-occupied = %name%
    label-occupied-padding = 1

    label-urgent = 
    label-urgent-background = ${red}
    label-urgent-overline  = ${red}
    label-urgent-padding = 2

    label-empty = %name%
    label-empty-foreground = ${gray}
    label-empty-overline = ${background}
    label-empty-padding = 1

    label-visible = %name%
    label-visible-overline = ${background}
    label-visible-padding = 2

    [module/xwindow]
    type = internal/xwindow
    label =   %title:0:40:...%
    label-empty = root-window
    label-empty-foreground = ${yellow}
    label-padding = 1
    click-left = skippy-xd
    click-right = skippy-xd
    '';

    # necessary to include i3 path to start correctly
    script = ''
      PATH=$PATH:${pkgs.i3}/bin polybar top &
    '';
  };

  home.packages = with pkgs; [
    glibcLocales # for rofi
    feh # image viewer, also for desktop wallpaper
    flameshot # image capture x11 only
    xorg.xauth
    xorg.twm
    xorg.xmodmap
    xterm
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
        exec --no-startup-id "picom"
        default_orientation vertical
        workspace_layout stacking
        exec xmodmap -e "clear lock" #disable caps lock switch
        exec xmodmap -e "keysym Caps_Lock = Escape" #set caps_lock as escape
      '';
    };
  };
}
