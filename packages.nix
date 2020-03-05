{ config, pkgs, ... }:

let
      
in { home.packages = with pkgs; [

      #cli
      htop # performance monitor
      ranger # file manager
      # hunter # rust based file manager
      vifm # vim file manager
      broot # awesome file manager, sorter, finder
      fzf # fuzzy finder and launcher
      youtube-dl # video downloader
      bat # cat with syntax highlighting
      dust # du replacement
      ripgrep # fast rust grepping tool
      megatools # mega.nz cli tools
      fzf # fuzzy file search
      autojump # z/j directory jump for zsh
      peco # output/list filtering
      tealdeer # rust tldr client - man page summarising https://github.com/dbrgn/tealdeer
      gitAndTools.tig # c-based curses git client https://github.com/jonas/tig

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
      patchelf # patch elf binaries for nixos

      # network
      # nmap
      httpie

      # disks
      parted # disk partitioning
      # bashmount # removable disk mount/unmount https://github.com/jamielinux/bashmount
      # diskrsync
      # diskscan # scan disks for errors
      btrfs-progs # btrfs utilities
      # ncdu # disk usage

      # web services
      googler # google cli
      haxor-news # hacker news cli
      rtv # reddit cli

      # system
      appimage-run

      # terminals
      # terminator
      # termite
      alacritty
      kitty

      # crypto
      # wasabiwallet

      # ide
      vscodium
      nixfmt
      sublime3
      sublime-merge
      emacs

      # i3
      # i3
      # i3status-rust
      rofi
      waybar
      # wofi grim wl-clipboard imv slurp brightnessctl bemenu
      vanilla-dmz # scalable cursor

      # browsers
      brave
      chromium
      vivaldi-ffmpeg-codecs
      firefox-wayland
      surf # suckless browser

      # chat
      signal-desktop
      tdesktop # telegram

      # sound
      pulsemixer # ncurses pulseaudio mixer
      spotify
      # cmus

      # video
      mpv

      # graphics
      blender

      # file management
      xfce.thunar
      broot

      # screenshots
      slurp # selector

      # lxappearance # customise gtk2 appearance
      lxappearance-gtk3 # gtk3 appearance

      # dirty hax
      glibcLocales

      # gtk themes
      hicolor-icon-theme # required by wofi
      deepin.deepin-gtk-theme
      deepin.deepin-icon-theme
      deepin.dde-launcher
      capitaine-cursors # mouse cursor
];}