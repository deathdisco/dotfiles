{ config, lib, pkgs, ... }: {
  # https://nixos.wiki/wiki/IGVT-g
  # ls /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/
  # cat /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_8/description
  # nix run nixpkgs.libossp_uuid -c uuid

  # environment.systemPackages = with pkgs; [ virtmanager ];

  # virtualisation.kvmgt.enable = true;
  # virtualisation.kvmgt.vgpus = {
  #   i915-GVTg_V5_8.uuid = [ "17d182c0-f6c3-11ea-8f07-73e5a9d78eef" ];
  # };
  # users.extraUsers.user.extraGroups = [ "libvirtd" ];

  # virtualisation.lxd.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
    qemuRunAsRoot = false;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  boot.kernelParams = [ "security=apparmor" ];
}
