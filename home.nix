# check https://github.com/balsoft/nixos-config

{ config, pkgs, ... }:

let
  # todo: extract to a separate file or environment vars
  nixpkgs = (builtins.fetchTarball
    (builtins.fromJSON (builtins.readFile ./nixpkgs.lock.json)));
  settings = (import ./settings.nix);
  colors = settings.colors;
in {

  imports = [
    ./hidpi.nix
    ./packages.nix
    ./i3/i3wm.nix
    ./package-sets/development.nix
  ];

  programs.bash.sessionVariables.EDITOR = "vim";

  programs.zsh = {
    enable = true;
    promptInit = "";
    interactiveShellInit = ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

      # Customize your oh-my-zsh options here
      ZSH_THEME="robbyrussell"
      plugins=(git docker)

      bindkey '\e[5~' history-beginning-search-backward
      bindkey '\e[6~' history-beginning-search-forward

      HISTFILESIZE=500000
      HISTSIZE=500000
      setopt SHARE_HISTORY
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_DUPS
      setopt INC_APPEND_HISTORY
      autoload -U compinit && compinit
      unsetopt menu_complete
      setopt completealiases

      if [ -f ~/.aliases ]; then
        source ~/.aliases
      fi

      source $ZSH/oh-my-zsh.sh
    '';
  };

  # users.extraUsers.USER = {
  #   shell = pkgs.zsh;
  # };

  nixpkgs.config = {
    allowUnfree = true;

    environment.variables = {
      EDITOR = "vim";
      PATH = "~/.cargo/bin:$PATH";
    };

    environment.profileVariables = (i:
      { PATH = [ "${i}/cargo/bin" ];
    });

    fonts.fontconfig.enable = true;
  };




  programs = {
    home-manager.enable = true;

    # rofi = {
    #   enable = true;
    #   theme = "${./rofi/themes/material.rasi}";
    # };

    vim = {
      enable = true;
      # plugins = [ "vim-airline" "goyo" ];
      settings = { ignorecase = true; };
      extraConfig = ''
        set mouse=a
      '';

      # to see available plugins:
      # nix-env -f '<nixpkgs>' -qaP -A vimPlugins
      plugins = with pkgs.vimPlugins;
        [
          # Writing
          goyo          # distraction-free writing; toggle with :Goyo
          vim-pencil    # better word-wrapping, markdown, etc.
          limelight-vim # highlight only current paragraph

          nerdtree

          # Languages
          vim-nix

          # Syntax checking / status
          syntastic
        ];
    };

    # vscodium-with-extensions = {
    #   enable = true;
    # };
  };

  # home.file.".icons/default".source = "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors"; 

  xsession = {
    enable = true;

    pointerCursor = {
      name = "deepin";
      package = pkgs.deepin.deepin-gtk-theme;
      size = 96;
    };
  };

  home.file = {
    ".config/sway" = {
      source = ./sway;
      recursive = true;
    };

    ".config/waybar" = {
      source = ./waybar;
      recursive = true;
    };

    ".config/ranger" = {
      source = ./ranger;
      recursive = true;
    };

    # appimages
    ".local/share/applications" = {
      source = ./applications;
      recursive = true;
    };

    ".config/Typora/themes" = {
      source = ./typora/themes;
      recursive = true;
    };

    ".config/i3/status.toml".source = ./i3/i3status-rust.toml;
  };

  home.file.".config/kitty/kitty.conf".text = ''
    background ${colors.grey-dark}
    background_opacity 0.88
    font_size 11.0
    input_delay 0

    clear_all_shortcuts yes
    rectangle_select_modifiers alt

    map ctrl+shift+c copy_to_clipboard
    map ctrl+v paste_from_clipboard
    map ctrl+equal change_font_size all +1.0
    map ctrl+minus change_font_size all -1.0
    map ctrl+k clear_terminal scrollback active
  '';

  home = {
    sessionVariables = {
      EDITOR = "vim";
      LANG = "en_US.UTF-8";
      PATH = "~/.cargo/bin:$PATH";
    };

    stateVersion = "19.09";
  };
}
