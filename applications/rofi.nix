{ pkgs, ... }:
{
  # common tasks launcher script
  # run with: rofi -show fb -modi fb:$HOME/.config/rofi/shortcuts.sh
  home.file.".config/rofi/shortcuts.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      if [[ -z "$@" ]]; then
          echo "codium $HOME/.config/dotfiles/"
          echo "codium $HOME/Notes"
          echo "home-manager switch --file $HOME/.config/dotfiles/profiles/nixos.nix"
      else
          $@
      fi
    '';
  };

  programs = {
    rofi = {
      enable = true;
      font = "Source Code Pro 18";
      padding = 20;
      colors = {
        window = {
          background = "#FF0000AA";
          border = "argb:582a373e";
          separator = "#00000000";
        };
        rows = {
          normal = {
            background = "#00FF0060";
            foreground = "#fafbfc";
            backgroundAlt = "#0000FFAA";
            highlight = {
              background = "#00bcd4";
              foreground = "#fafbfc";
            };
          };
        };
      };
    };
  };
}
