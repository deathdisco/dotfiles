{ config, pkgs, ... }:

let
      
in { home.packages = with pkgs; [

      #cli
      htop ytop gotop # performance monitor
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
      autojump # z/j directory jump for zsh
      peco # output/list filtering
      tealdeer # rust tldr client - man page summarising https://github.com/dbrgn/tealdeer
      gitAndTools.tig # c-based curses git client https://github.com/jonas/tig
      ctodo # todo list
      exa # ls replacement

      # vm
      libvirt
      virt-manager # qemu based graphical frontend

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
      wavemon # wifi monitoring ncurses

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
      alacritty
      kitty

      # ncurses toys
      cmatrix

      # crypto
      # wasabiwallet

      # ide
      vscodium
      nixfmt
      sublime3
      sublime-merge
      emacs

      # text / markdown
      typora

      # i3
      # i3
      # i3status-rust
      rofi
      waybar
      # wofi grim wl-clipboard imv slurp brightnessctl bemenu
      vanilla-dmz # scalable cursor

      # browsers
      brave
      opera
      qutebrowser
      # vivaldi-ffmpeg-codecs
      firefox-wayland

      # chat
      signal-desktop
      tdesktop # telegram

      compton-git

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
