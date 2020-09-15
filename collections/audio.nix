{ config, pkgs, ... }:
with pkgs; {
  home.packages = [
    (pkgs.callPackage ../packages/orca.nix { }) # orca sequencer
    # sunvox # synth and pattern based sequencer
    (renoise.override { releasePath = /home/sway/Downloads/rns_322_linux_x86_64.tar.gz; })
  ];
}
