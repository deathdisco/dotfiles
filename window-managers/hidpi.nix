{ config, pkgs, ... }: {
  xresources.properties = {
    "Xft.dpi" = "220"; # cursors, i3bar, then multiplied for GDK etc
    # "Xft.autohint" = 0;
    # "Xft.lcdfilter" = "lcddefault";
    # "Xft.hintstyle" = "hintfull";
    # "Xft.hinting" = 1;
    # "Xft.antialias" = 1;
    # "Xft.rgba" = "rgb";
  };

  home.packages = with pkgs; [
    bibata-cursors
    bibata-extra-cursors
  ];

  # Classic, Ice, Oil, Amber, Turquoise, Pink, DodgerBlue, DarkRed

  xsession.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata Oil";
    size = 60;
  };

  home.sessionVariables = {
    GDK_SCALE = 1.0; # ?
    GDK_DPI_SCALE = 1.0; # brave, chromium, vscode (smaller)
    ELM_SCALE = 1.5; # elementary apps
    #GRUB_FONT = "/boot/grubfont.pf2";
    PLASMA_USE_QT_SCALING = 1;
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
  };
}
