{ config, pkgs, ... }:

let
  # todo: extract to a separate file or environment vars
  email = "rob@wearebrandnew.com";
  github-username = "robsaunders";
  dotfiles = "~/.dotfiles";
  nixpkgs = (builtins.fetchTarball
    (builtins.fromJSON (builtins.readFile ./nixpkgs.lock.json)));
  color--pink = "#FC0394";
  color--black = "#000000";
  color--white = "#FFFFFF";
  color--grey-dark = "#111111";
  color--grey-medium = "#888888";
  color--grey-light = "#d8dee8";
  color--red = "#900000";
in {
  nixpkgs.config.allowUnfree = true;

  programs = {
    home-manager.enable = true;

    rofi = {
      enable = true;
      # font = "${font} 20";
      theme = "${dotfiles}/i3/rofi/themes/material.rasi";
    };

    termite = {
      enable = true;
      # font = "${font} 11";
      backgroundColor = "rgba(32, 39, 51, 0.3)";
    };
  };

  xsession = {
    enable = true;
    windowManager.i3 = rec {
      enable = true;
      config = {
        modifier = "Mod1";

        bars = [{
          mode = "dock";
          position = "top";
          statusCommand = "/usr/bin/i3status";

          extraConfig = ''
            binding_mode_indicator yes
          '';

          colors = {
            background = "${color--black}";
            focusedWorkspace = {
              background = "${color--pink}";
              border = "${color--pink}";
              text = "${color--white}";
            };
            activeWorkspace = {
              background = "${color--black}";
              border = "${color--black}";
              text = "${color--grey-light}";
            };
            inactiveWorkspace = {
              background = "${color--black}";
              border = "${color--black}";
              text = "${color--grey-light}";
            };
            urgentWorkspace = {
              background = "${color--red}";
              border = "${color--black}";
              text = "${color--black}";
            };
            # binding mode is when workspaces have different keybindings
            bindingMode = {
              background = "${color--black}";
              border = "${color--black}";
              text = "${color--pink}";
            };
          };
        }];

        window.border = 0;
        # window.hideEdgeBorders = "smart";
        floating.border = 0;

        colors = {
          background = "${color--black}";
          focused = {
            border = "${color--black}";
            background = "${color--black}";
            text = "${color--pink}";
            indicator = "${color--grey-medium}";
            childBorder = "${color--grey-medium}";
          };
          focusedInactive = {
            border = "${color--black}";
            background = "${color--black}";
            text = "${color--grey-light}";
            indicator = "${color--black}";
            childBorder = "${color--black}";
          };
          unfocused = {
            border = "${color--black}";
            background = "${color--black}";
            text = "${color--grey-medium}";
            indicator = "${color--black}";
            childBorder = "${color--black}";
          };
          urgent = {
            border = "${color--red}";
            background = "${color--red}";
            text = "${color--grey-light}";
            indicator = "${color--black}";
            childBorder = "${color--black}";
          };
          placeholder = {
            border = "${color--grey-dark}";
            background = "${color--grey-dark}";
            text = "${color--grey-light}";
            indicator = "${color--black}";
            childBorder = "${color--black}";
          };
        };

        keybindings = let mod = config.modifier;
        in {

          # launchers
          "${mod}+f" = "exec thunar";
          "${mod}+d" = "exec dmenu_run";
          "${mod}+space" = "exec /usr/bin/rofi -show drun";
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

          # reload the configuration file
          "Ctrl+Shift+c" = "reload";
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
          "XF86MonBrightnessUp" =
            "exec ${pkgs.xorg.xbacklight}/bin/xbacklight -inc 5";
          "XF86MonBrightnessDown" =
            "exec ${pkgs.xorg.xbacklight}/bin/xbacklight -dec 5";
        };
      };

      extraConfig = ''
        default_orientation vertical
        workspace_layout stacking
      '';
    };
  };

  home = {
    stateVersion = "19.09";

    packages = [
      # cli
      pkgs.htop # performance monitor
      pkgs.ranger # file manager
      # pkgs.hunter # rust based file manager
      pkgs.vifm # vim file manager
      pkgs.broot # awesome file manager, sorter, finder
      pkgs.fzf # fuzzy finder and launcher

      # dev
      pkgs.nixfmt # nix formatter

      # i3
      pkgs.i3
      pkgs.i3status
      pkgs.rofi

      # gui
      pkgs.xfce.thunar
    ];

    file = { };
  };
}

# {
#   programs.home-manager.enable = true;

#   home.packages = [
#     pkgs.htop   # performance monitor
#     pkgs.ranger # file manager
#     pkgs.broot  # awesome file manager, sorter, finder
#     pkgs.fzf    # fuzzy finder
#   ];

#   home.file = {
#     ".example".text = "blah blah";
#   };

#   # home-manager version compatibility
#   home.stateVersion = "19.09";
# }
