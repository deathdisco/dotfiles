# dotfiles
[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

Configuration for NixOS and [home-manager](https://github.com/rycee/home-manager).

## Installation

I don't recommend using these files yourself, but pick and choose pieces. I'm trying to keep all files modular, but to be honest it's still a little messy.

``` bash
make system # install nixos system for Dell XPS 9500
make # install home-manager profile for x11+wayland i3 environment
```

## Content

- `/examples`: other peoples nix configurations I find useful for reference
- `/flakes`: slowly moving to flakes over packages
- `/home-manager`: my `home-manager` config (user configuration)
- `/iso`: scripts to build bootable nixOS installation isos
- `/machines`: nixOS systems
- `/packages`: custom nix packages I have made for unsupported applications
- `/scripts`: helper scripts to build the system
- `/shells`: nix-shells
- `/templates`: I link this to ~/.shells to provide various quick nix-shells
- `/wallpapers`: self explanatory

## Notes

Installing unfree packages with flakes means using a non-hermetic environment.
``` bash:
nix profile install nixpkgs#_1password-gui --impure
```
