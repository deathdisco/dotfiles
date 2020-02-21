# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Use the gummiboot efi boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_4_8;

  networking = {
    hostName = "nixos"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;

    # Allow ChromeCast to send/receive packets
    # http://askubuntu.com/a/326224/177448
    firewall.extraCommands = ''
      iptables -I INPUT -p udp -m udp --dport 32768:60999 -j ACCEPT
    '';
  };

  hardware.facetimehd.enable = true;
  hardware.bluetooth.enable = true;

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      inconsolata
      source-code-pro
      ubuntu_font_family
      unifont
      ipaexfont
    ];
  };

  # Select internationalisation properties.
  i18n = {
    #    consoleFont = "su12x22";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
    inputMethod.enabled = "fcitx";
    inputMethod.ibus.engines = with pkgs.ibus-engines; [ mozc ];
    inputMethod.fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    dbus

    # Utility
    atop
    awscli
    direnv
    file
    jq
    manpages
    nox
    peco
    powertop
    psmisc
    silver-searcher
    slack
    terminator
    tmux
    w3m
    wget
    which
    xsel
    unzip
    zip

    # Editor
    emacs
    vim

    # Development
    docker
    python35Packages.docker_compose
    git
    gnumake
    mercurial
    tig
    zsh

    # X & Desktop
    blueman
    dmenu
    evince
    i3lock
    i3status
    gnome3.dconf
    gnome3.gnome-screenshot
    gnome3.networkmanagerapplet
    gnome3.gnome_settings_daemon
    arandr # RandR GUI frontend
    pavucontrol # pactl GUI frontend
    xautolock
    xdg_utils
    xdg-user-dirs
    xorg.xev
    xorg.xmodmap
    xfce.thunar
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  #  services.xserver.autorun = false;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.dpi = 150;

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  services.tlp.enable = true;

  services.xserver.xkbOptions = "ctrl:nocaps";

  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;
  services.xserver.synaptics.accelFactor = "0.017";
  services.xserver.synaptics.minSpeed = "0.6";
  services.xserver.synaptics.maxSpeed = "2.0";
  services.xserver.synaptics.scrollDelta = -350;
  services.xserver.synaptics.fingersMap = [ 1 3 2 ];

  services.xserver.desktopManager.xterm.enable = false;
  # KDE5
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.kde5.enable = true;

  # Gnome3
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome3.enable = true;

  # LightDM
  services.xserver.displayManager.lightdm.enable = true;

  ## i3
  services.xserver.windowManager.i3.enable = true;

  ## Docker
  virtualisation.docker.enable = true;

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.k2nr = {
    home = "/home/k2nr";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    password = "password";
    shell = "/run/current-system/sw/bin/zsh";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "unstable";
}
