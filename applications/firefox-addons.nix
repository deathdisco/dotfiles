self: super:

let
  buildFirefoxXpiAddon = { addonId, name, url, sha256, meta, ... }:
    super.stdenv.mkDerivation {
      inherit name meta;

      src = super.fetchurl {
        inherit url sha256;
      };

      preferLocalBuild = true;
      allowSubstitutes = false;

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p $dst
        install -v -m644 $src $dst/${addonId}.xpi
      '';
    };

in

{
  firefox-addons = super.callPackage ./firefox-addons-generated.nix {
    inherit buildFirefoxXpiAddon;
  };
}
