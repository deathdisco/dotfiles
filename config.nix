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

  allowUnfree = true;
  firefox.enableAdobeFlash = false;
  pulseaudio = true;
}
