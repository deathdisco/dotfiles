# dotfiles
[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

Configuration for NixOS and [home-manager](https://github.com/rycee/home-manager).

## Setup

Link `configuration.nix` as root and rebuild nix.
```
sudo ln ./system /etc/nixos
sudo nixos-rebuild switch
```

Then set up user environment (without sudo).

```
ln . .config/nixpkgs
home-manager switch
```
