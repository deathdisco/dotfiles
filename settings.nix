{
  email = "deathdisco@tutanota.com";
  github-username = "monomadic";
  wallpaper = "~/dotfiles/wallpapers/mirroring.png";
  colors = rec {
    black = "#000000";
    white = "#FFFFFF";
    pink = "#FC0394";
    red = "#900000";
    grey-dark = "#111111";
    grey-medium = "#888888";
    grey-light = "#d8dee8";
    sea-blue = "rgb(82, 157, 242)";
    neon-green = "rgb(60, 255, 136)";

    ui = {
      background = black;
      text = white;
    };

    firefox = {
      background = black;
      text = white;
      accent = pink;
      selected-tab-background = white;
      selected-tab-text = black;
      menu-icon = pink;
    };
  };
  fonts = rec {
    mono = "Source Code Pro";
    sans = "Noto Sans";

    applications = {
      firefox = "monospace";
    };
  };
}
