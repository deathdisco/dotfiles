{ pkgs, mod }: {

  # note: to get current keybindings, `xmodmap -pke` or interactive: `xev'

  # launchers
  "${mod}+f" = "exec thunar";
  "${mod}+d" = "exec dmenu_run";
  "${mod}+space" =
    "exec LOCALE_ARCHIVE=$HOME/.nix-profile/lib/locale/locale-archive rofi -show drun";
  "${mod}+shift+space" =
    "exec rofi -show fb -modi fb:$HOME/.config/rofi/shortcuts.sh";
  "Ctrl+space" = "exec alacritty";
  "${mod}+s" = "exec rofi -show windowcd";
  "Super_L" = "exec skippy-xd";

  # change focus
  "${mod}+n" = "focus down";
  # "${mod}+p" = "focus up";
  "${mod}+shift+Tab" = "focus right";
  "${mod}+Tab" = "focus left";

  # change container layout (stacked, tabbed, toggle split)
  "${mod}+e" = "layout stacking";
  "${mod}+r" = "layout tabbed";
  "${mod}+t" = "layout toggle split";
  "${mod}+w" = "floating toggle";

  # window management
  "${mod}+q" = "kill";
  "${mod}+Return" = "fullscreen toggle";

  # switch to workspace
  # "${mod}+Tab" = "workspace next";
  # "${mod}+Shift+Tab" = "workspace prev";
  "${mod}+1" = "workspace 1";
  "${mod}+2" = "workspace 2";
  "${mod}+3" = "workspace 3";
  "${mod}+4" = "workspace 4";
  "${mod}+5" = "workspace 5";
  "${mod}+6" = "workspace 6";
  "${mod}+7" = "workspace 7";
  "${mod}+8" = "workspace 8";
  "${mod}+9" = "workspace 9";
  "${mod}+0" = "workspace 10";

  # move focused container to workspace
  "${mod}+Shift+1" = "move container to workspace 1";
  "${mod}+Shift+2" = "move container to workspace 2";
  "${mod}+Shift+3" = "move container to workspace 3";
  "${mod}+Shift+4" = "move container to workspace 4";
  "${mod}+Shift+5" = "move container to workspace 5";
  "${mod}+Shift+6" = "move container to workspace 6";
  "${mod}+Shift+7" = "move container to workspace 7";
  "${mod}+Shift+8" = "move container to workspace 8";
  "${mod}+Shift+9" = "move container to workspace 9";
  "${mod}+Shift+10" = "move container to workspace 10";

  # move container
  "${mod}+Shift+Left" = "move left";
  "${mod}+Shift+Down" = "move down";
  "${mod}+Shift+Up" = "move up";
  "${mod}+Shift+Right" = "move right";

  # reload the configuration file
  "${mod}+Shift+e" = "reload";
  # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
  "${mod}+Shift+r" = "restart";
  # exit i3 (logs you out of your X session)
  "${mod}+Shift+q" =
    "exec i3-nagbar -t warning -m 'Do you really want to quit i3?' -b 'Yes, exit i3' 'i3-msg exit'";

  # media keys
  "XF86AudioRaiseVolume" =
    "exec ${pkgs.pulseaudioFull}/bin/pactl set-sink-volume 0 +5%";
  "XF86AudioLowerVolume" =
    "exec ${pkgs.pulseaudioFull}/bin/pactl set-sink-volume 0 -5%";
  "XF86AudioMute" =
    "exec ${pkgs.pulseaudioFull}/bin/pactl set-sink-mute 0 toggle";
  "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
  "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl pause";
  "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
  "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

  # brightness keys
  "XF86MonBrightnessUp" = "exec ${pkgs.xorg.xbacklight}/bin/xbacklight -inc 5";
  "XF86MonBrightnessDown" =
    "exec ${pkgs.xorg.xbacklight}/bin/xbacklight -dec 5";
}
