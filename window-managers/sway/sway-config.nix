{ pkgs, settings }:
''
    # https://github.com/swaywm/sway/wiki

    #########################
    # Run services
    #########################
    # exec mako
    # exec waybar

    font pango:monospace 9
    floating_modifier Mod1
    default_border normal 0
    # default_floating_border normal 0
    default_orientation vertical
    focus_follows_mouse no
    workspace_layout tabbed
    for_window [class=".*"] floating enable
    for_window [title="[.]*"] floating enable
    for_window [app_id=".*"] floating enable
    exec xmodmap -e "clear lock" #disable caps lock switch
    exec xmodmap -e "keysym Caps_Lock = Escape" #set caps_lock as escape
    bindcode Mod1+34 workspace prev
    bindcode Mod1+35 workspace next
    # hide_edge_borders none
    # focus_wrapping no
    # focus_follows_mouse yes
    # focus_on_window_activation smart
    # mouse_warping output
    # workspace_layout default
    # gaps inner 10
    
    seat seat0 xcursor_theme "capitaine-cursors"

    # output eDP-1 pos 1920 0 scale 1.5 res 3840x2400

    # set $laptop eDP-1
    # bindswitch --reload lid:on output $laptop disable
    # bindswitch --reload lid:off output $laptop enable

    output eDP-1 scale 2.0 bg ${settings.wallpaper} stretch
    exec xrdb -load ~/.Xresources

    # <border> <background> <text> <indicator> <child_border>
    client.focused #000000DD #000000DD #d8dee8 #888888 #888888
    # client.focused_inactive #000000DD #000000DD #d8dee8 #000000 #000000
    # client.unfocused #000000DD #000000DD #888888 #000000 #000000
    # client.urgent #900000 #900000 #d8dee8 #000000 #000000
    # client.placeholder #111111 #111111 #d8dee8 #000000 #000000
    # client.background #000000

    bindsym Ctrl+Space exec alacritty
    # bindsym Mod1+Space exec rofi -show drun
    bindsym Mod1+Space exec BEMENU_BACKEND=wayland bemenu-run --bottom --line-height=25 --list=5 --prompt="?" --prefix=">" --nb="#00000044"
    bindsym Mod1+0 workspace 10
    bindsym Mod1+1 workspace 1
    bindsym Mod1+2 workspace 2
    bindsym Mod1+3 workspace 3
    bindsym Mod1+4 workspace 4
    bindsym Mod1+5 workspace 5
    bindsym Mod1+6 workspace 6
    bindsym Mod1+7 workspace 7
    bindsym Mod1+8 workspace 8
    bindsym Mod1+9 workspace 9
    bindsym Mod1+Return fullscreen toggle
    bindsym Mod1+Semicolon focus right
    bindsym Mod1+Shift+1 move container to workspace 1
    bindsym Mod1+Shift+0 move container to workspace 10
    bindsym Mod1+Shift+2 move container to workspace 2
    bindsym Mod1+Shift+3 move container to workspace 3
    bindsym Mod1+Shift+4 move container to workspace 4
    bindsym Mod1+Shift+5 move container to workspace 5
    bindsym Mod1+Shift+6 move container to workspace 6
    bindsym Mod1+Shift+7 move container to workspace 7
    bindsym Mod1+Shift+8 move container to workspace 8
    bindsym Mod1+Shift+9 move container to workspace 9
    bindsym Mod1+Shift+Down move down
    bindsym Mod1+Shift+Left move left
    bindsym Mod1+Shift+Right move right
    bindsym Mod1+Shift+Tab workspace prev
    bindsym Mod1+Shift+Up move up
    bindsym Mod1+Shift+e reload
    bindsym Mod1+Shift+q exec i3-msg exit
    bindsym Mod1+Shift+r restart
    bindsym Mod1+Tab workspace nextin { text = text; }

    bindsym Mod1+w floating toggle

    bindsym Mod1+f exec thunar
    bindsym Mod1+j focus left
    bindsym Mod1+n focus down
    bindsym Mod1+p focus up
    bindsym Mod1+q kill
    bindsym XF86AudioLowerVolume exec pactl set-sink-volume 0 -5%
    bindsym XF86AudioMute exec pactl set-sink-mute 0 toggle
    bindsym XF86AudioNext exec playerctl next
    bindsym XF86AudioPause exec playerctl pause
    bindsym XF86AudioPlay exec playerctl play
    bindsym XF86AudioPrev exec playerctl previous
    bindsym XF86AudioRaiseVolume exec pactl set-sink-volume 0 +5%
    bindsym XF86MonBrightnessDown exec xbacklight -dec 5
    bindsym XF86MonBrightnessUp exec xbacklight -inc 5

    ### Idle configuration
    #

    # exec swayidle -w \
    #   timeout 300 'swaylock -f -c 000000' \
    #   timeout 600 'swaymsg "output * dpms off"' \
    #   resume 'swaymsg "output * dpms on"' \
    #   before-sleep 'swaylock -f -c 000000'

    # This will lock your screen after 300 seconds of inactivity, then turn off
    # your displays after another 300 seconds, and turn your screens back on when
    # resumed. It will also lock your screen before your computer goes to sleep.

    ### Input configuration
    #

    # input "ELAN962C:00 04F3:30D0 Touchpad" {
    #   dwt enabled
    #   tap enabled
    #   natural_scroll enabled
    #   middle_emulation disabled
    # }

     bar {
       font pango:monospace 9
       mode dock
       hidden_state hide
       position top
       #swaybar_command ${pkgs.i3status-rust}/bin/i3status-rs $HOME/.config/sway/i3status-rust.toml
       status_command ${pkgs.i3status-rust}/bin/i3status-rs $HOME/.config/sway/i3status-rust.toml
       workspace_buttons yes
       strip_workspace_numbers no
       tray_output primary
       colors {
         background #00000066
         statusline #ffffff
         separator #666666
         focused_workspace #FC0394 #FC0394 #FFFFFF
         active_workspace #000000 #000000 #d8dee8
         inactive_workspace #000000 #000000 #d8dee8
         urgent_workspace #900000 #900000 #000000
         binding_mode #000000 #000000 #FC0394
       }
       binding_mode_indicator yes
     }

    # default_orientation vertical
    # workspace_layout stacking
  ''
