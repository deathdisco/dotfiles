{ config, pkgs, ... }:

let
  # todo: extract to a separate file or environment vars
  email = "rob@wearebrandnew.com";
  github-username = "robsaunders";
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
  # todo: check if this actually gets used...
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.services.xserver.dpi = 166;
  nixpkgs.config.fonts.fontconfig.dpi = 167;

  programs = {
    home-manager.enable = true;

    rofi = {
      enable = true;
      theme = "${./rofi/themes/material.rasi}";
    };

    termite = {
      enable = true;
      # font = "${font} 11";
      backgroundColor = "rgba(32, 39, 51, 0.3)";
    };
  };

  xsession = {
    enable = true;

    pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 128;
    };

    windowManager.i3 = rec {
      enable = true;
      config = {
        modifier = "Mod1";
        modes = { };

        bars = [{
          mode = "dock";
          position = "top";
          statusCommand =
            "${pkgs.i3status-rust}/bin/i3status-rs ${./i3/i3status-rust.toml}";

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
              border = "${color--red}";
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

        keybindings = import ./i3/keybindings.nix {
          mod = config.modifier;
          pkgs = pkgs;
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

    # this fixes a locales bug when using nix as a package manager.
    # sessionVariables.LOCALE_ARCHIVE =
    #   "${pkgs.glibcLocales}/lib/locale/locale-archive";

    packages = [
      # cli
      pkgs.htop # performance monitor
      pkgs.ranger # file manager
      # pkgs.hunter # rust based file manager
      pkgs.vifm # vim file manager
      pkgs.broot # awesome file manager, sorter, finder
      pkgs.fzf # fuzzy finder and launcher
      pkgs.jq # jquery cli parser

      # dev
      pkgs.vscodium
      pkgs.nixfmt # nix formatter

      # i3
      pkgs.i3
      pkgs.i3status-rust
      pkgs.rofi

      # browsers
      pkgs.chromium
      pkgs.brave

      # sound
      pkgs.pulsemixer

      # gui: file management
      pkgs.xfce.thunar

      # gui: chat
      pkgs.signal-desktop # signal, secure private im
      pkgs.tdesktop # telegram, also secure private im

      # dirty hax
      pkgs.glibcLocales
    ];
  };
}
