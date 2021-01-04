# link: sudo ln -s /../systems/huawei-matebook-13/nixos /etc/nixos # NOTE: USE FULL PATHS
# nixos-rebuild switch

{ config, pkgs, inputs, ... }: {
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    trustedUsers = [ "root" "sway" ];
  };

  imports = [
    #"${inputs.nixpkgs}/nixos/modules/installer/scan/not-detected.nix"
    # ./virtualisation.nix
    #<nixos-hardware/dell/xps/15-9500>
    ./hardware-configuration.nix
    #./services.nix
  ];

  # ----------------------------------------------------------------------------
  # USERS

  # users.defaultUserShell = pkgs.zsh;
  # users.users.nom = {
  #   isNormalUser = true;
  #   home = "/home/nom";
  #   extraGroups = [ "wheel" "networkmanager" "audio" "libvirtd" ];
  # };

  users.users.sway = {
    isNormalUser = true;
    home = "/home/sway";
    extraGroups = [ "wheel" "networkmanager" "audio" "libvirtd" "lxd" ];
  };

  # ----------------------------------------------------------------------------
  # SYSTEM PACKAGES

  environment.systemPackages = with pkgs; [
    gnutar
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
    # pmutils # power management, laptop suspend, lid close etc
    # virtmanager
    mesa
    mesa_drivers
  ];

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [ waybar swayidle xwayland ];
  };

  # programs.home-manager.enable = true;

  # remap caps lock to ctrl
  # services.xserver.xkbOptions = "ctrl:swapcaps";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  #boot.loader.grub.device = "nodev";
  #boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.useOSProber = true;
  # boot.blacklistedKernelModules = [ "nouveau" ];
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # text only prompt, no display manager
  # services.xserver.displayManager.startx.enable = true;

  # ----------------------------------------------------------------------------
  # NETWORKING

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking = {
    networkmanager.enable = true; # networkmanager

    #   # wireless.enable = true; # wpa_supplicant
    #   # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    #   # wireless.iwd.enable = true;
    #   # networkmanager.wifi.backend = "iwd";

    #   #useDHCP = false; # deprecated
    #   #interfaces.wlp0s20f3.useDHCP = true;

    usePredictableInterfaceNames = true;
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
  sound.enable = true;

  # ----------------------------------------------------------------------------
  # FONTS

  fonts.fonts = with pkgs; [
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
    (callPackage ./source-code-pro.nix { })
    terminus_font
    # capitaine-cursors
  ];

  # High-DPI console font
  console.font = pkgs.lib.mkDefault
    "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  # ----------------------------------------------------------------------------
  # HIDPI

  #fonts.fontconfig.dpi = 150;
  # services.xserver.dpi = 150;
  #services.xserver.dpi = 166;

  #environment.variables = {
  #  GDK_DPI_SCALE = "0.5";
  #  GDK_SCALE = "0.5";
  #  QT_AUTO_SCREEN_SCALE_FACTOR = "1.5";
  #  XCURSOR_SIZE = "64";
  #};

  # ----------------------------------------------------------------------------
  # X11

  # ----------------------------------------------------------------------------
  # DISPLAY / ACCELERATION

  # hardware.nvidia.modesettings.enable = true;
  # hardware.opengl = {
  #   enable = true;

  #   #  extraPackages = with pkgs; [
  #   #   # linuxPackages.nvidia_x11.out
  #   #  vaapiIntel
  #   # vaapiVdpau
  #   #libvdpau-va-gl
  #   #];
  #   #driSupport = true;
  #   #driSupport32Bit = true;

  #   # extraPackages32 = with pkgs; [ linuxPackages.nvidia_x11.lib32 ];
  # };

  # ----------------------------------------------------------------------------
  # VIRTUAL MACHINES
  #
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/virtualisation/kvmgt.nix
  # cat /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_4/description

  # virtualisation.kvmgt.enable = true;
  # # virtualisation.kvmgt.vgpus = {
  # #   "i915-GVTg_V5_8" = { uuid = "a297db4a-f4c2-11e6-90f6-d3b88d6c9525"; };
  # # };
  # environment.systemPackages = with pkgs; [ virtmanager ];
  # users.extraUsers.user.extraGroups = [ "libvirtd" ];

  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemuOvmf = true;
  #   qemuRunAsRoot = false;
  #   onBoot = "ignore";
  #   onShutdown = "shutdown";
  # };

  # virtualisation = {
  #   lxd.enable = true;

  #   # Intel IGVT-g
  #   kvmgt.enable = true;
  #   # kvmgt.vgpus = {
  #   #   "i915-GVTg_V5_8" = { uuid = "c8c7c576-a5f1-11ea-8ef9-934db6f9cef5"; };
  #   # };

  #   libvirtd.enable = true;

  #   # libvirtd = {
  #   #   enable = true;
  #   #   qemuOvmf = true;
  #   #   qemuRunAsRoot = false;
  #   #   onBoot = "ignore";
  #   #   onShutdown = "shutdown";
  #   # };
  # };

  # environment.systemPackages = [ pkgs.virtmanager ];

  # ----------------------------------------------------------------------------
  # SERVICES

  services = {

    openssh.enable = true;

    # Enable touchpad support.
    xserver = {

      enable = true;

      autorun = false;
      exportConfiguration = true;
      layout = "us";
      #videoDrivers = [ "intel" ];
      # libinput.enable = true;
      displayManager.defaultSession = "none+i3"; # disable desktop manager
      desktopManager.xterm.enable = false;
      displayManager.lightdm.enable = true;
      windowManager.i3.enable = true;
      displayManager.startx.enable = true;
      #synaptics = {
      #  enable = true;
      #  dev = "/dev/input/event*";
      #  twoFingerScroll = true;
      #  tapButtons = false;
      #  accelFactor = "0.05";
      #  buttonsMap = [ 1 3 2 ];
      #  palmDetect = true;
      #  additionalOptions = ''
      #    Option "VertScrollDelta" "-180" # scroll sensitivity, the bigger the negative number = less sensitive
      #    Option "HorizScrollDelta" "-180"
      #    Option "FingerLow" "40"
      #    Option "FingerHigh" "70"
      #    Option "Resolution" "270" # Pointer sensitivity, this is for a retina screen, so you'll probably need to change this for an air
      #    Option "RightButtonAreaLeft" "0"
      #    Option "RightButtonAreaTop" "0"
      #  '';
      #};
    };
  };

  # ----------------------------------------------------------------------------
  # EVILPATCH
  # This links loaders in a very non-nix-like way.
  # Allows you to run unpatched binaries.
  # Evil.

  # /lib64
  # environment.extraInit = let loader = "ld-linux-x86-64.so.2"; in ''
  #   export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/run/current-system/sw/lib:${pkgs.glibc}/lib"
  #   ln -fs ${pkgs.glibc}/lib/${loader} /lib64/${loader}
  # '';

  # /lib
  # environment.extraInit = with pkgs; let loader = "ld-linux-x86-64.so.2"; in ''
  #   export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/run/current-system/sw/lib"
  #   ln -fs ${pkgs.glibc}/lib/${loader} /lib/${loader}
  # '';

  # ----------------------------------------------------------------------------
  # ENVIRONMENT/SHELL

  # Set your time zone.
  time.timeZone = "Australia/Hobart";

  environment.variables = { EDITOR = "vim"; };

  # system.stateVersion = "19.09"; # Did you read the comment?
}
