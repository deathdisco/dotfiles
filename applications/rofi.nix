{ pkgs, home, ... }:
{
  # common tasks launcher script
  # run with: rofi -show fb -modi fb:$HOME/.config/rofi/shortcuts.sh
  # place shortcuts in a ~/.shortcuts text file
  home.file.".config/rofi/shortcuts.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      if [[ -z "$@" ]]; then
        cat "$HOME/.shortcuts"
      else
        exec $@
      fi
    '';
  };

  home.file.".config/rofi/config.rasi" = {
    executable = true;
    text = ''
      configuration {
        font: "Source Code Pro 30";
        location: 0;
        padding: 60;
        yoffset: 0;
        xoffset: 0;
        color-normal: "#00FF0060, #fafbfc, #0000FFAA, #00bcd4, #fafbfc";
        color-window: "argb:DD0A0705, argb:FF2a373e, #00000000";
      }
    '';
  };

  home.packages = with pkgs; [ rofi ];

  # programs = {
  #   rofi = {
  #     enable = true;
  #     font = "Source Code Pro 30";
  #     padding = 60;
  #     colors = {
  #       window = {
  #         background = "argb:DD0A0705";
  #         border = "argb:FF2a373e";
  #         separator = "#00000000";
  #       };
  #       rows = {
  #         normal = {
  #           background = "#00FF0060";
  #           foreground = "#fafbfc";
  #           backgroundAlt = "#0000FFAA";
  #           highlight = {
  #             background = "#00bcd4";
  #             foreground = "#fafbfc";
  #           };
  #         };
  #       };
  #     };
  #   };
  # };
}
