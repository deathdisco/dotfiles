{ config, lib, pkgs, ... }:

{
  # imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];
  nixpkgs.overlays = [
    (self: super:
      let
        nixpkgs-mesa = builtins.fetchTarball
          "https://github.com/nixos/nixpkgs/archive/bdac777becdbb8780c35be4f552c9d4518fe0bdb.tar.gz";
      in { mesa_drivers = (import nixpkgs-mesa { }).mesa_drivers; })
  ];

  hardware.enableRedistributableFirmware = true;

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];

  # boot.extraModprobeConfig = "options nvidia-drm modeset=1";
  # boot.initrd.kernelModules =
  #   [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  boot.kernelModules = [ "kvm-intel" ]; # "kvmgt"
  boot.kernelParams = [ "i915.enable_gvt=1" ];

  environment.variables = { MESA_LOADER_DRIVER_OVERRIDE = "iris"; };

  hardware.opengl.enable = true;
  # hardware.opengl.package = (pkgs.mesa.override {
  #   galliumDrivers = [ "nouveau" "virgl" "swrast" "iris" ];
  # }).drivers;
  hardware.opengl.package = pkgs.mesa_drivers;

  # hardware.nvidia.modesetting.enable = true;
  # hardware.nvidia.prime = {
  #   enable = true;
  #   intelBusId = "PCI:0:2:0";
  #   nvidiaBusId = "PCI:1:0:0";
  # };

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

  # nix.maxJobs = lib.mkDefault 8;
  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand"; # "powersave"
  };
}
