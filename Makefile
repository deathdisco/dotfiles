legacy:
	sudo bash scripts/install machines/dell-xps-15
	home-manager switch --file home-manager/users/nixos.nix

update:
	nix flake update --update-input nixpkgs
	nix flake update --update-input home-manager
	nix flake update --update-input nixos-hardware

build:
	set -x
	sudo nixos-rebuild switch --flake '.#' --impure
