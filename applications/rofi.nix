{ pkgs, ... }:
{
  programs = {
    rofi = {
      enable = true;
      font = "FuraCode Nerd Font 18";
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