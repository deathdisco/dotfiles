# https://git.sr.ht/~rabbits/orca

with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "orca";
  src = (builtins.fetchGit "https://git.sr.ht/~rabbits/orca");

  buildInputs = [ ncurses portmidi ];

  buildPhase = ''
    find .
    bash ./tool build --portmidi orca
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./build/orca $out/bin/orca
    chmod +x $out/bin/orca
  '';
}
