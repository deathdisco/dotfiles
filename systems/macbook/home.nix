# macos home-manager configuration
#
#   home-manager switch --file ./home.nix
#   brew install $(cat homebrew.txt)
#
{ config, pkgs, ... }:
let
in {
  imports = [ ../../applications/alacritty.nix ];

  programs.bash.sessionVariables.EDITOR = "vim";

  nixpkgs.config = {
    allowUnfree = true;

    environment.variables = {
      EDITOR = "vim";
      PATH = "~/.cargo/bin:$PATH";
    };
  };

  home = {
    packages = [
      # NIX
      pkgs.nixfmt

      # CLI
      pkgs.ranger
      pkgs.gnupg1compat # gpg encryption

      # GUI
    ];
  };
}
