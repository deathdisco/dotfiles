# build:
# nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix
# sudo dd bs=4M if=result/iso/nixos-20.09pre231837.2cd2e7267e5-x86_64-linux.iso of=/dev/sda

{config, pkgs, lib, ...}:
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
    utillinux ncdu fd
    hack-font
    wget curl git file pciutils
    vim amp
    ranger
    sway firefox gparted
  ];

  networking.hostName = "bootynixx";
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;
}
