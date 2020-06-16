{ xcursorTheme xcursorPackage xcursorSize }:
{
 xresources.properties = {
    "Xcursor.theme" = xcursorTheme;
    "Xcursor.size"  = xcursorSize;
  };
  gtk.gtk2.extraConfig = ''
    gtk-cursor-theme-name="${xcursorTheme}"
    gtk-cursor-theme-size=${toString xcursorSize}
  '';
  gtk.gtk3.extraConfig = {
    "gtk-cursor-theme-name" = xcursorTheme;
    "gtk-cursor-theme-size" = xcursorSize;
  };
  xsession.initExtra = ''
    # ...other stuff...
    xsetroot -xcf ${xcursorPackage}/share/icons/${xcursorTheme}/cursors/X_cursor ${toString xcursorSize}
  '';
}
