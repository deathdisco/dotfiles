# build:
# nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix
# sudo dd bs=4M if=result/iso/nixos-20.09pre231837.2cd2e7267e5-x86_64-linux.iso of=/dev/sda
# https://nixos.mayflower.consulting/blog/2018/09/11/custom-images/

{ config, pkgs, lib, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    # <home-manager/nixos>
    # ../window-managers/i3/i3.nix
    # ../applications/alacritty.nix
    # ../applications/vim.nix
    # ../applications/rofi.nix
  ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    utillinux gparted ncdu fd
    # hack-font st i3
    wget curl git file pciutils
    vim amp
    firefox
    ranger
    alacritty kitty
    sway
  ];

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
      source-code-pro
      terminus_font
    ];

  # High-DPI console
  console.font =
    lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  nixpkgs.config.xsession.pointerCursor = pkgs.capitaine-cursors;
  nixpkgs.config.xresources.properties = {
    "Xcursor.theme" = "capitaine-cursors";
    "Xcursor.size" = "76";
    "Xft.dpi" = "155"; # application dpi for most X11 apps
  };

  networking.hostName = "bootynix";
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;
  

  # hardware.opengl = {
  #   enable = true;

  #   extraPackages = with pkgs; [
  #     # linuxPackages.nvidia_x11.out
  #     vaapiIntel
  #     vaapiVdpau
  #     libvdpau-va-gl
  #   ];
  #   driSupport = true;
  #   driSupport32Bit = true;

  #   # extraPackages32 = with pkgs; [ linuxPackages.nvidia_x11.lib32 ];
  # };

  # services.xserver.displayManager.startx.enable = true;
  
  # services = {

  #   openssh.enable = true;

  #   # Enable touchpad support.
  #   xserver = {

  #     enable = true;

  #     autorun = false;
  #     exportConfiguration = true;
  #     layout = "us";
  #     videoDrivers = [ "intel" ];
  #     # libinput.enable = true;
  #     displayManager.defaultSession = "none+i3"; # disable desktop manager
  #     desktopManager.xterm.enable = false;
  #     displayManager.lightdm.enable = true;
  #     windowManager.i3.enable = true;
  #     displayManager.startx.enable = true;
  #     synaptics = {
  #       enable = true;
  #       dev = "/dev/input/event*";
  #       twoFingerScroll = true;
  #       tapButtons = false;
  #       accelFactor = "0.05";
  #       buttonsMap = [ 1 3 2 ];
  #       palmDetect = true;
  #       additionalOptions = ''
  #         Option "VertScrollDelta" "-180" # scroll sensitivity, the bigger the negative number = less sensitive
  #         Option "HorizScrollDelta" "-180"
  #         Option "FingerLow" "40"
  #         Option "FingerHigh" "70"
  #         Option "Resolution" "270" # Pointer sensitivity, this is for a retina screen, so you'll probably need to change this for an air
  #         Option "RightButtonAreaLeft" "0"
  #         Option "RightButtonAreaTop" "0"
  #       '';
  #     };
  #   };
  # };

  hardware.pulseaudio.enable = true;
}
