# macos home-manager configuration
#
#   home-manager switch --file ./home.nix
#   brew install $(cat homebrew.txt)
#
{ config, pkgs, ... }:
let
in {
  imports = [
    # ../../applications/alacritty.nix
    # ../../packages.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;

    environment.sessionVariables = {
      EDITOR = "vim";
      PATH = "~/.bin:~/.cargo/bin:$PATH";
    };
  };

  home = {
    packages = with pkgs; [
      # NIX
      htop ytop gotop # performance monitor
      ranger # file manager
      dragon-drop # drag and drop for cli / x / ranger
      tmux # terminal multiplexer
      byobu # alternative text multiplexers
      glow # markdown preview
      atool # decompression
      amp # rust based cli xi frontend
      unrar
      neofetch

      nixfmt

      # CLI
      gnupg1compat # gpg encryption

      # GUI
    ];
  };
}
