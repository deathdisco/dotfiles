{ config, pkgs, ... }:
let
  homeDir = builtins.getEnv("HOME");
in {
  local.darwin.machine = "nombook";

  imports = [
    # ./display.nix
    # ./hardware-configuration.nix
  ];

  # SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [
    home-manager
    nox # package manager
  ];

  environment.variables = {
    EDITOR = "vim";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
}
