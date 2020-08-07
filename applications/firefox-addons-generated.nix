{ buildFirefoxXpiAddon, fetchurl, stdenv }: {
  "1password-x-password-manager" = buildFirefoxXpiAddon {
    pname = "1password-x-password-manager";
    version = "1.20.0";
    addonId = "{d634138d-c276-4fc8-924b-40a0ea21d284}";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/3597753/1password_x_password_manager-1.20.0-fx.xpi?src=";
    sha256 = "ec3c46d4c1f4a7a7be8055a7327e207cf037f8ca579af9cd9930499732632569";
    meta = with stdenv.lib; {
      homepage = "https://1password.com";
      description =
        "The best way to experience 1Password in your browser. Easily sign in to sites, generate passwords, and store secure information, including logins, credit cards, notes, and more.";
      license = {
        shortName = "1pwd";
        fullName = "Service Agreement for 1Password users and customers";
        url = "https://1password.com/legal/terms-of-service/";
        free = false;
      };
      platforms = platforms.all;
    };
  };
}
