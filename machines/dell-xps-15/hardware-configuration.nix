{ config, lib, pkgs, ... }:
let
  killerWifiFirmware = pkgs.fetchzip {
    url =
      "https://wireless.wiki.kernel.org/_media/en/users/drivers/iwlwifi/iwlwifi-qu-48.13675109.0.tgz";
    sha256 = "1iq6fy50pv36zsd3qxbyjs3rn1x2541v8z74kcd3n0hqs6406xni";
  };
in {
  # imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];
  nixpkgs.overlays = [
    (self: super:
      let
        nixpkgs-mesa = builtins.fetchTarball {
          url =
            "https://github.com/nixos/nixpkgs/archive/bdac777becdbb8780c35be4f552c9d4518fe0bdb.tar.gz";
          sha256 = "18hi3cgagzkrxrwv6d9yjazqg5q2kiacjn3hhb94j4gs6c6kdxrk";
        };
      in { mesa_drivers = (import nixpkgs-mesa { }).mesa_drivers; })
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [
    (pkgs.runCommandNoCC "killerWifiFirmware" { } ''
      mkdir -p $out/lib/firmware
      cp ${killerWifiFirmware}/iwlwifi-Qu-*-48.ucode $out/lib/firmware
    '')
  ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];

  # boot.extraModprobeConfig = "options nvidia-drm modeset=1";
  # boot.initrd.kernelModules =
  #   [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  # boot.kernelModules = [ "kvm-intel" ]; # "kvmgt"
  # boot.kernelParams = [ "i915.enable_gvt=1" ];

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
  # powerManagement = {
  #   enable = true;
  #   cpuFreqGovernor = lib.mkDefault "ondemand"; # "powersave"
  # };
}
