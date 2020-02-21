{ pkgs }:
    {
        with pkgs; [
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
      bat # cat with syntax highlighting

      # terminals
      terminator
      termite
      # alacritty # not working
      # kitty # not working

      # ide
      vscodium
      nixfmt

      # i3
      i3
      i3status-rust
      rofi

      # browsers
      brave
      chromium

      # chat
      signal-desktop
      tdesktop # telegram

      # sound
      pulsemixer

      # file management
      xfce.thunar

      # dirty hax
      glibcLocales
        ];
    }
