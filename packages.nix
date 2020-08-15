# TODO move this and clean it up

{ config, pkgs, ... }:
{ home.packages = with pkgs; [
      scim # ncurses spreadsheet
      nixfmt
      killall

      #cli
      htop ytop gotop # performance monitor

      gnupg # used by ripasso
      apg # password gen

      ranger # file manager
      tmux # terminal multiplexer
      byobu # alternative text multiplexer

      glow # markdown preview

      # sxiv # suckless image viewer

      atool # decompression

      # bspwm

      unrar
      neofetch

      broot # awesome file manager, sorter, finder
      fff # fucking fast file manager

      fzf # fuzzy finder and launcher
      fd # rust alternative to find
      youtube-dl # video downloader
      bat # cat with syntax highlighting
      # dust # du replacement
      ripgrep # fast rust grepping tool
      megatools # mega.nz cli tools
      # autojump # z/j directory jump for zsh
      peco # output/list filtering
      tealdeer # rust tldr client - man page summarising https://github.com/dbrgn/tealdeer
      gitAndTools.tig # c-based curses git client https://github.com/jonas/tig
      ctodo # todo list
      exa # ls replacement

      kakoune # terminal editor
      amp # rust based cli xi frontend
      ffmpeg

      nox # better nix package manager frontend
      # chafa # image to ascii converter

      # web dev stuff
      gron # json grepper
      jq # json cli parser
      http-prompt # interactive http api (built on httpie)
      jid # drill down json (golang) https://github.com/simeji/jid

      # re stuff
      hexyl # hex editor
      hecate # hex editor (golang) https://github.com/evanmiller/hecate

      # archives
      unzip
      # patchelf # patch elf binaries for nixos

      # network
      # nmap
      httpie
      # wavemon # wifi monitoring ncurses

      # disks
      # parted # disk partitioning
      # bashmount # removable disk mount/unmount https://github.com/jamielinux/bashmount
      # diskrsync
      # diskscan # scan disks for errors
      # btrfs-progs # btrfs utilities
      # ncdu # disk usage

      # web services
      googler # google cli
      haxor-news # hacker news cli
      rtv # reddit cli

      # ncurses toys
      cmatrix

      # file management
      broot

      # screenshots
      slurp # selector
];}
