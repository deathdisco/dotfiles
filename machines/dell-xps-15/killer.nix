{ config, pkgs, ... }:
let
  killerWifiFirmware = pkgs.fetchzip {
    url =
      "https://wireless.wiki.kernel.org/_media/en/users/drivers/iwlwifi/iwlwifi-qu-48.13675109.0.tgz";
    sha256 = "1iq6fy50pv36zsd3qxbyjs3rn1x2541v8z74kcd3n0hqs6406xni";
  };

in {
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [
    (pkgs.runCommandNoCC "killerWifiFirmware" { } ''
      mkdir -p $out/lib/firmware
      cp ${killerWifiFirmware}/iwlwifi-Qu-*-48.ucode $out/lib/firmware
    '')
  ];
}
