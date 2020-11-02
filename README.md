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

- `/applications`: home manager configured application configs
- `/examples`: other nix configurations I find useful
- `/packages`: custom nix packages I have made for unsupported applications
- `/profiles`: home manager configurations
- `/shells`: nix-shells
- `/systems`: nixos system configurations for native nixos installs
- `/templates`: starter templates for programming I use. more on this later.
- `/wallpapers`: self explanatory
