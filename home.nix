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
    ./applications/alacritty.nix
  ];

  programs.bash.sessionVariables.EDITOR = "vim";

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
        set nobackup
        set noswapfile

        let g:NERDTreeMouseMode=2
        let g:NERDTreeHijackNetrw=0

        map <C-b> :NERDTreeToggle<CR>
        map <C-w> :close<CR>
        map <C-t> :tabnew<CR>
        map <C-j> :tabprev<CR>
        map <C-k> :tabnext<CR>
        map <C-s> :write<CR>
        map <C-q> :quit<CR>

        nnoremap 1 1gt
        nnoremap 2 2gt
        nnoremap 3 3gt
        nnoremap 4 4gt
        nnoremap 5 5gt
        nnoremap 6 6gt
        nnoremap 7 7gt
        nnoremap 8 8gt
        nnoremap 9 9gt
      '';

      # to see available plugins:
      # nix-env -f '<nixpkgs>' -qaP -A vimPlugins
      plugins = with pkgs.vimPlugins;
        [
          # writing
          goyo          # distraction-free writing; toggle with :Goyo
          vim-pencil    # better word-wrapping, markdown, etc.
          limelight-vim # highlight only current paragraph
          vimwiki

          # search
          ctrlp

          # sidebar
          nerdtree

          # languages
          vim-nix

          # syntax checking / status
          syntastic

          # typescript
          coc-tslint
          yats-vim

          vim-devicons
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

    # .desktop files
    ".local/share/applications" = {
      source = ./applications/desktopfiles;
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
