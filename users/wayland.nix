{ config, pkgs, ... }:
with import ../settings.nix; {
  imports = [
    ../packages.nix
    ../window-managers/i3/i3.nix
    ../window-managers/sway/sway.nix
    ../window-managers/hidpi.nix
    ../applications/alacritty.nix
    ../applications/kitty.nix
    #../applications/zsh.nix
    #../applications/tmux.nix
    #../applications/skippy.nix
    # editors
    #../applications/vim.nix
    ../applications/rofi.nix
    ../applications/vscodium.nix
    ../applications/firefox.nix
    #../applications/wayland.nix
    ../applications/pass.nix

    ../collections/audio.nix
  ];

  nixpkgs.config.xsession.pointerCursor = nixpkgs.capitaine-cursors;

  # should likely be in nixos config, not hm
  nixpkgs.config = {
    allowUnfree = true;

    environment.variables = {
      EDITOR = "vim";
      PATH = "~/.cargo/bin:$PATH";
    };

    environment.profileVariables = (i: { PATH = [ "${i}/cargo/bin" ]; });

    fonts.fontconfig.enable = true;
  };

  programs = {
    home-manager.enable = true; # required by home manager

    bash = {
      enable = true;
      sessionVariables.EDITOR = "vim";
      bashrcExtra = ''
        alias ls='exa'
        alias j='zrs'
        alias z='zrs'
        # source /home/nom/.local/share/zrs/z.sh
        PS1="\w> "
      '';
    };

    git = {
      enable = true;
      userName = "monomadic";
      userEmail = "deathdisco@protonmail.com";
    };
  };

  home.file = {

    ".config/waybar" = {
      source = ../window-managers/sway/waybar;
      recursive = true;
    };

    ".config/ranger" = {
      source = ../applications/ranger;
      recursive = true;
    };

    ".xinitrc".text = ''
      xrdb ~/.Xresources
      exec i3
      # picom -b --config ~/.config/picom.conf
    '';

    # (manually do this instead)
    # ".templates" = {
    #   source = ../templates;
    #   recursive = true;
    # };

    # .desktop files
    #".local/share/applications" = {
    #  source = ./applications/desktopfiles;
    #  recursive = true;
    #};

    #".config/Typora/themes" = {
    #  source = ./typora/themes;
    #  recursive = true;
    #};

    # ".config/i3/status.toml".source = ../window-managers/i3/i3status-rust.toml;
  };

  home = {
    packages = with pkgs; [
      brave
      sublime3
      capitaine-cursors
      tdesktop
      signal-desktop
    ];

    sessionVariables = {
      EDITOR = "vim";
      LANG = "en_US.UTF-8";
      PATH = "~/.cargo/bin:$PATH";
    };

    stateVersion = "19.09";
  };
}
