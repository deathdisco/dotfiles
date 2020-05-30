{
  # imports = [ ./packages/chromium-wayland.nix ];
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
    videoDrivers = [ "nvidia" ];
    screenSection = ''
      Option "metamodes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
    '';
    dpi = 221;
    # displayManager.gdm.wayland = false;
  };
  # environment.systemPackages = [ pkgs.nvtop ];
  
  # compton = {
  #   enable = true;
  #   fade = true;
  #   shadow = true;
  #   # backend = "glx";
  #   # vSync = "opengl-swc";
  #   # extraOptions = ''
  #   #   paint-on-overlay = true;
  #   #   glx-no-stencil = true;
  #   #   glx-no-rebind-pixmap = true;
  #   #   glx-swap-method = "buffer-age";
  #   #   sw-opti = true;
  #   #   xrender-sync-fence = true;
  #   # '';
  # };
}
