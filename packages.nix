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
      jq # jquery cli parser
      youtube-dl # video downloader
      bat # cat with syntax highlighting
      dust # du replacement
      ripgrep # fast rust grepping tool
      megatools # mega.nz cli tools

      # disks
      parted # disk partitioning
      # bashmount # removable disk mount/unmount https://github.com/jamielinux/bashmount
      # diskrsync
      # diskscan # scan disks for errors

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

      # i3
      # i3
      # i3status-rust
      rofi
      waybar
      # wofi grim wl-clipboard imv slurp brightnessctl bemenu

      # browsers
      brave
      chromium
      vivaldi-ffmpeg-codecs
      firefox-wayland

      # chat
      signal-desktop
      tdesktop # telegram

      # sound
      pulsemixer

      # video
      mpv

      # file management
      xfce.thunar

      # dirty hax
      glibcLocales

      # gtk themes
      hicolor-icon-theme # required by wofi
];}