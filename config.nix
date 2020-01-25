{
  packageOverrides = pkgs:
    with pkgs; {
      myPackages = pkgs.polybar.override {
        i3GapsSupport = true;
        i3Support = true;
        alsaSupport = true;
        iwSupport = true;
        githubSupport = true;
      };
    };

  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };

  # services.xserver.dpi = 164;

  allowUnfree = true;
  firefox.enableAdobeFlash = false;
  pulseaudio = true;
}
