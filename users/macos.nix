# macos home-manager configuration
#
#   home-manager switch --file ./macos.nix
#
{ config, pkgs, ... }:
{
  imports = [
	    # ../packages.nix
      ../applications/alacritty.nix
      ../applications/zsh.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.zsh.sessionVariables = {
    EDITOR = "amp";
    PATH = "$HOME/.bin:$HOME/.cargo/bin:$PATH";
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
