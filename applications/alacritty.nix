{ config, pkgs, ... }:

let
  settings = (import ../settings.nix);
  colors = settings.colors;

in {
  programs = {
    alacritty = {
      enable = true;

      settings = {

        # env = { "TERM" = "xterm-256color"; };

        background_opacity = 0.90;

        window = {
          padding.x = 10;
          padding.y = 10;
          dimensions = {
            lines = 25;
            columns = 100;
          };
          key_bindings = [
            {
              key = "K";
              mods = "Control";
              chars = "\\x0c";
            }
          ];
          # decorations = "buttonless";
        };

        font = {
          size = 12.0;
          use_thin_strokes = true;

          normal.family = "${settings.fonts.mono}";
          bold.family = "${settings.fonts.mono}";
          italic.family = "${settings.fonts.mono}";
        };

        # cursor.style = "Beam";

        # shell = {
        #   program = "zsh";
        #   args = [ "-C" "neofetch" ];
        # };


        colors = {
          # Default colors
          primary = {
            background = "${settings.colors.terminal.background}";
            foreground = "0xcbe3e7";
          };

          # Normal colors
          normal = {
            black = "0x100e11";
            red = "0xff8080";
            green = "0x62d196";
            yellow = "0xffe9aa";
            blue = "0x389cff";
            magenta = "0xc991e1";
            cyan = "0xaaffe4";
            white = "0xcbe3e7";
          };

          # Bright colors
          bright = {
            black = "0x565575";
            red = "0xff5458";
            green = "0x5cff38";
            yellow = "0xffb378";
            blue = "0x65b2ff";
            magenta = "0x906cff";
            cyan = "0x63f2f1";
            white = "0xa6b3cc";
          };
        };
      };
    };
  };
}
