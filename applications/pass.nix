# spotify command line client

{ pkgs, home, ... }:
let
  pass-with-extensions =
    pkgs.pass.withExtensions (e: [ e.pass-audit e.pass-genphrase e.pass-otp ]);
in {
  home.packages = with pkgs; [
    pass-with-extensions
    ripasso-cursive # ncurses gpg password manager in rust, compatible with pass
    
    gnupg # used by ripasso
    apg # password gen

    pinentry-curses # needed for PIN entry on cli
  ];

  # pinentry
  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      pinentry-program ${pkgs.pinentry-curses}/bin/pinentry-curses
    '';
  };
}
