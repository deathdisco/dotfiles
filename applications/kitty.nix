{ config, pkgs, ... }:

let
  settings = (import ../settings.nix);
  colors = settings.colors;

in {

  home.file.".config/applications/kitty/kitty.conf".text = ''
    background ${colors.grey-dark}
    background_opacity 0.88
    font_size 11.0
    input_delay 0

    clear_all_shortcuts yes
    rectangle_select_modifiers alt

    map ctrl+shift+c copy_to_clipboard
    map ctrl+v paste_from_clipboard
    map ctrl+equal change_font_size all +1.0
    map ctrl+minus change_font_size all -1.0
    map ctrl+k clear_terminal scrollback active
  '';

}
