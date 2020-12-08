{
  description = "Monomadic NixOS System Config";

  inputs = {
    # sudo nix-channel --add https://nixos.org/channels/nixos-20.03 nixos
    stable.url = "github:NixOS/nixpkgs/nixos-20.03";
    unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home = {
      url = "github:rycee/home-manager/bqv-flakes";
      inputs.nixpkgs.follows = "stable";
    };
    nur.url = "github:nix-community/NUR";
    hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, stable, unstable, home, nur, hardware }: rec {
    inherit (stable) lib;
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          hardware.nixosModules.dell-xps-15-9500
          ./machines/dell-xps-15/configuration.nix
          home.nixosModules.home-manager
          {
            home.useGlobalPkgs = true;
            home.useUserPackages = true;
            home.users.sway = import ./home-manager/users/nixos.nix;
          }
        ];
      };
    };
  };
}
