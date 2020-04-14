# configuration.nix /etc/nixos/configuration.nix
# nixos-rebuild switch

{ config, pkgs, ... }:
let
    nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
        exec -a "$0" "$@"
    '';
in
{
  imports = [
    ./hardware-configuration.nix
  ];


  # SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [
    nvidia-offload
    wget vim_configurable zsh git home-manager
    file # file identification
    diskus # fast alternative to du -sh
    ncdu # ncurses disk usage
    # gdmap dua # disk usage viewers
    ntfs3g exfat-utils # windows compatibility
    pciutils # lspci
    glxinfo # opengl
  ];

  # environment.variables = {
  #   _JAVA_AWT_WM_NONREPARTENTING = "1";
  #   GDK_SCALE = "1.5";
  #   QT_AUTO_SCREEN_SCALE_FACTOR = "1.5";
  #   XCURSOR_SIZE = "32";
  #   GDK_DPI_SCALE = "1.4";
  # };

  environment.variables = {
    EDITOR = "vim";
  };

  nixpkgs.config.allowUnfree = true;

  # remap caps lock to ctrl
  # services.xserver.xkbOptions = "ctrl:swapcaps";

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # boot.loader.grub.useOSProber = true;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  
  # needed by i3-gaps
  # environment.pathsToLink = [ "/libexec" ];

  # DISPLAY

  #hardware.bumblebee.enable = true;
  #hardware.bumblebee.connectDisplay = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  # services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    # sync.enable = true;
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # BLUETOOTH
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  services.blueman.enable = true;

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # FONTS
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    proggyfonts
    nerdfonts
    font-awesome
    dejavu_fonts
    source-code-pro
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Australia/Hobart";

  # virtual machines with lxd
  virtualisation.lxd.enable = true;

  # desktop
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      grim # screenshot util
      i3status-rust # status bar
      imv # image viewer for wayland
      kanshi
      mako
      # redshift # color temperature
      slurp
      swaybg # desktop background https://github.com/swaywm/swaybg
      swayidle
      swaylock # lock screen
      wl-clipboard # cut copy paste support
      xwayland # compatibility layer for x11 apps
    ];
  };
  fonts.fontconfig.dpi = 150;
  services.xserver.dpi = 150;

  #programs.home-manager.enable = true;
  #programs.home-manager.path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Users
  users.users.nom = {
    isNormalUser = true;
    home = "/home/nom";
    extraGroups = [ "wheel" "networkmanager" "audio" "lxd" ];
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
  };

  # text only prompt, no display manager
  # services.xserver.displayManager.startx.enable = true;

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}
