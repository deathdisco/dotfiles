# link: sudo ln -s /../systems/huawei-matebook-13/nixos /etc/nixos # NOTE: USE FULL PATHS
# nixos-rebuild switch

{ config, pkgs, ... }: {
  # imports = [ ./display.nix ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # ----------------------------------------------------------------------------
  # FILESYSTEM

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems = { "/drives/data".device = "/dev/disk/by-label/data"; };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };

  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  # ----------------------------------------------------------------------------
  # USERS

  # users.defaultUserShell = pkgs.zsh;
  users.users.nom = {
    isNormalUser = true;
    home = "/home/nom";
    extraGroups = [ "wheel" "networkmanager" "audio" "lxd" "libvirtd" ];
  };

  # ----------------------------------------------------------------------------
  # SYSTEM PACKAGES

  environment.systemPackages = with pkgs; [
    wget
    vim_configurable
    git
    home-manager
    file # file identification
    diskus # fast alternative to du -sh
    ncdu # ncurses disk usage
    ntfs3g
    exfat-utils # windows compatibility
    pciutils # includes lspci
    glxinfo # opengl
    pmutils # power management, laptop suspend, lid close etc
    virtmanager # is this necessary?
  ];

  # programs.home-manager.enable = true;

  # remap caps lock to ctrl
  # services.xserver.xkbOptions = "ctrl:swapcaps";

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.useOSProber = true;

  # text only prompt, no display manager
  # services.xserver.displayManager.startx.enable = true;

  # ----------------------------------------------------------------------------
  # NETWORKING

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking = {
    networkmanager.enable = true; # networkmanager
    # wireless.enable = true; # wpa_supplicant

    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # wireless.iwd.enable = true;
    # networkmanager.wifi.backend = "iwd";
    # wireless.networks = {
    # };

    # networking.wireless.networks = {
    #   echelon = {
    #     pskRaw = "dca6d6ed41f4ab5a984c9f55f6f66d4efdc720ebf66959810f4329bb391c5435";
    #   };
    # }
    # # wpa_passphrase ESSID PSK

    useDHCP = false; # deprecated
    interfaces.wlp0s20f3.useDHCP = true;
  };

  # ----------------------------------------------------------------------------
  # BLUETOOTH

  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  services.blueman.enable = true;

  # ----------------------------------------------------------------------------
  # AUDIO

  # hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.support32Bit = true;
  # sound.enable = true;

  # ----------------------------------------------------------------------------
  # FONTS

  fonts.fonts = with pkgs; [
    dejavu_fonts
    dina-font
    fira-code
    fira-code-symbols
    font-awesome
    liberation_ttf
    mplus-outline-fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    powerline-fonts
    proggyfonts
    source-code-pro
    terminus_font
    virtmanager
  ];

  console.font =
    lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  # ----------------------------------------------------------------------------
  # HIDPI

  fonts.fontconfig.dpi = 150;
  # services.xserver.dpi = 150;
  services.xserver.dpi = 166;

  environment.variables = {
    GDK_DPI_SCALE = "1.5";
    GDK_SCALE = "1.5";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1.5";
    XCURSOR_SIZE = "64";
  };

  # ----------------------------------------------------------------------------
  # X11
  
  services.xserver = {
    enable = true;

    autorun = false;
    exportConfiguration = true;
    layout = "us";
    videoDrivers = [ "intel" ];
    # libinput.enable = true;
    # desktopManager.default = "none"; # disable desktop manager
    # displayManager.startx.enable = true;
  };

  # ----------------------------------------------------------------------------
  # DISPLAY / ACCELERATION

  hardware.opengl = {
    enable = true;

    extraPackages = with pkgs; [
      # linuxPackages.nvidia_x11.out
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
    driSupport = true;
    driSupport32Bit = true;

    # extraPackages32 = with pkgs; [ linuxPackages.nvidia_x11.lib32 ];
  };

  # ----------------------------------------------------------------------------
  # VIRTUAL MACHINES
  #
  # https://gitlab.com/xaverdh/nixpkgs/blob/3e7bbe45e828301cca2eff578474eab5e6a889e3/nixos/modules/virtualisation/kvmgt.nix
  # cat /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_4/description 

  virtualisation = {
    # lxd.enable = true;

    kvmgt.enable = true; # Intel IGVT-g
    kvmgt.vgpus = {
      "i915-GVTg_V5_8" = { uuid = "c8c7c576-a5f1-11ea-8ef9-934db6f9cef5"; };
    };
    libvirtd.enable = true;

    # libvirtd = {
    #   enable = true;
    #   qemuOvmf = true;
    #   qemuRunAsRoot = false;
    #   onBoot = "ignore";
    #   onShutdown = "shutdown";
    # };
  };

  # environment.systemPackages = [ pkgs.virtmanager ];

  # ----------------------------------------------------------------------------
  # SERVICES

  services = {

    openssh.enable = true;

    # Enable touchpad support.
    xserver = {
      synaptics = {
        enable = true;
        dev = "/dev/input/event*";
        twoFingerScroll = true;
        tapButtons = false;
        accelFactor = "0.05";
        buttonsMap = [ 1 3 2 ];
        palmDetect = true;
        additionalOptions = ''
          Option "VertScrollDelta" "-180" # scroll sensitivity, the bigger the negative number = less sensitive
          Option "HorizScrollDelta" "-180"
          Option "FingerLow" "40"
          Option "FingerHigh" "70"
          Option "Resolution" "270" # Pointer sensitivity, this is for a retina screen, so you'll probably need to change this for an air
          Option "RightButtonAreaLeft" "0"
          Option "RightButtonAreaTop" "0"
        '';
      };
    };
  };

  # ----------------------------------------------------------------------------
  # ENVIRONMENT/SHELL

  # Set your time zone.
  time.timeZone = "Australia/Hobart";

  # environment.variables = {
  #   _JAVA_AWT_WM_NONREPARTENTING = "1";
  #   GDK_SCALE = "1.5";
  #   QT_AUTO_SCREEN_SCALE_FACTOR = "1.5";
  #   XCURSOR_SIZE = "32";
  #   GDK_DPI_SCALE = "1.4";
  # };

  environment.variables = { EDITOR = "vim"; };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
