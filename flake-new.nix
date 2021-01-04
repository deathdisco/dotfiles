{
  description = "Monomadic NixOS System Config";

  inputs = {
    # sudo nix-channel --add https://nixos.org/channels/nixos-20.03 nixos
    # stable.url = "github:NixOS/nixpkgs/nixos-20.03";
    # unstable = { url = "nixpkgs/nixos-unstable"; };
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home-manager.url = "github:nix-community/home-manager";
    #nur.url = "github:nix-community/NUR";
    hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs:
    # ignore::
    let
      ignoreme = ({ config, lib, ... }:
        with lib; {
          system.nixos.revision = mkForce null;
          system.nixos.versionSuffix = mkForce "pre-git";
        });
    in {
      # inherit (unstable) lib;

      # lib.localSystem.system = "x86_64-linux";

      nixosConfigurations = {

        #lib.currentSystem.system = "x86_64-linux";

        nixos = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # inputs.hardware.nixosModules.dell-xps-15-9500
            # (import ./machines/minimal/configuration.nix)
            # ./machines/dell-xps-15/configuration.nix
            ./machines/dell-xps-15/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.sway = import ./home-manager/users/nixos.nix;
            }
          ];
        };
      };
    };
}
