{ config, pkgs, inputs, ... }: {
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;

  imports = [
    # note: this format can't be used with flakes, because it pulls from
    # NIX_PATH, which is impure, and dis-allowed with flakes.
    # Use the format shown in the line below it.

    #<nixpkgs/nixos/modules/installer/scan/not-detected.nix>

    "${modulesPath}/installer/scan/not-detected.nix"
  ];

  services.sshd.enable = true;

  networking.hostName = "nom";

  # nixpkgs.overlays = [ inputs.nur.overlay ];

  # environment.systemPackages = with pkgs; [ pkgs.nur.repos.mic92.hello-nur ];

  boot.loader.systemd-boot.enable = true; # (for UEFI systems only)
  fileSystems."/".device = "/dev/disk/by-label/nixos";
}
