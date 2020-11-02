{ pkgs, ... }:
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };
    extraConfig = let
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
      # inspired by /ossix/dotfiles/dark-forest
    in ''
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
      height = 28
      padding-left = 1
      padding-right = 2
      background = ${background}
      foreground = ${white}
      module-margin = 1
      underline-size = 1
      border-bottom-size = 0
      separator = " "

      font-0 = "Source Code Pro:style=Regular:size=8;0"
      font-1 = Font Awesome 5 Free:style=Regular:pixelsize=8;2
      font-2 = Font Awesome 5 Free:style=Solid:pixelsize=8;2


      enable-ipc = true

      modules-right = battery volume
      modules-center = date
      modules-left = i3

      #
      # Modules
      #

      [module/cpu]
      type = internal/cpu
      interval = 0.5

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
      format-padding-right = 0

      label-focused = %name%
      label-focused-foreground = ${white}
      label-focused-overline  = ${black}
      label-focused-padding = 1
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
}