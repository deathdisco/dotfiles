{ pkgs, mod }: {
  # launchers
  "${mod}+f" = "exec thunar";
  "${mod}+d" = "exec dmenu_run";
  "${mod}+space" =
    "exec LOCALE_ARCHIVE=$HOME/.nix-profile/lib/locale/locale-archive rofi -show drun";
  "${mod}+return" = "exec i3-sensible-terminal";

  # change focus
  "${mod}+j" = "focus left";
  "${mod}+n" = "focus down";
  "${mod}+p" = "focus up";
  "${mod}+semicolon" = "focus right";

  # change container layout (stacked, tabbed, toggle split)
  "${mod}+e" = "layout stacking";
  "${mod}+r" = "layout tabbed";
  "${mod}+t" = "layout toggle split";

  # window management
  "${mod}+q" = "kill";

  # switch to workspace
  "${mod}+tab" = "workspace next";
  "${mod}+shift+tab" = "workspace prev";
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
  "${mod}+shift+1" = "move container to workspace 1";
  "${mod}+shift+2" = "move container to workspace 2";
  "${mod}+shift+3" = "move container to workspace 3";
  "${mod}+shift+4" = "move container to workspace 4";
  "${mod}+shift+5" = "move container to workspace 5";
  "${mod}+shift+6" = "move container to workspace 6";
  "${mod}+shift+7" = "move container to workspace 7";
  "${mod}+shift+8" = "move container to workspace 8";
  "${mod}+shift+9" = "move container to workspace 9";
  "${mod}+shift+10" = "move container to workspace 10";

  # move container
  "${mod}+shift+left" = "move left";
  "${mod}+shift+down" = "move down";
  "${mod}+shift+up" = "move up";
  "${mod}+shift+right" = "move right";

  # reload the configuration file
  "ctrl+shift+c" = "reload";
  # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
  "${mod}+shift+r" = "restart";
  # exit i3 (logs you out of your X session)
  "${mod}+shift+q" =
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
