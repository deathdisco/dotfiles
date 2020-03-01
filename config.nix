{
  imports = [ ./packages/chromium-wayland.nix ];
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

  # environment.variables = {
  #   _JAVA_AWT_WM_NONREPARTENTING = "1";
  #   GDK_SCALE = "1.5";
  #   QT_AUTO_SCREEN_SCALE_FACTOR = "1.5";
  #   XCURSOR_SIZE = "32";
  #   GDK_DPI_SCALE = "1.4";
  # };

  # services.xserver.dpi = 164;

  allowUnfree = true;
  firefox.enableAdobeFlash = false;
  pulseaudio = true;

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig.dpi = 221;
  };

  xserver = {
    enable = true;
    dpi = 221;
  };

  compton = {
    enable = true;
    backend = "glx";
    vSync = "opengl";
    extraOptions = ''
      paint-on-overlay = true;
      glx-no-stencil = true;
      glx-no-rebind-pixmap = true;
      glx-swap-method = "buffer-age";
      sw-opti = true;
      xrender-sync-fence = true;
    '';
  };
}
