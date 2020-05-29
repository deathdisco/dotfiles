# check https://github.com/balsoft/nixos-config
{ config, pkgs, ... }:
with import ./settings.nix;
let
  # nixpkgs = (builtins.fetchTarball
  #  (builtins.fromJSON (builtins.readFile ./nixpkgs.lock.json)));
  # colors = settings.colors;
in {

  imports = [
    ./packages.nix
    ./desktop/i3/i3.nix
    # ./desktop/awesome/awesome.nix
    # ./desktop/sway/sway.nix
    #./package-sets/development.nix
    ./applications/alacritty.nix
    ./applications/kitty.nix
  ];
  
  # Enable zsh
  programs.zsh.enable = true;

  # Enable Oh-my-zsh
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "sudo" ];
  };

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
    home-manager.enable = true;
    # sway = ./desktop/sway/sway.nix;
    # sway.enable = true;

    # rofi = {
    #   enable = true;
    #   theme = "${./rofi/themes/material.rasi}";
    # };A

    tmux = {
      enable = true;
      extraConfig = ''
        set -g status-interval 2
        set -g status-left "#S #[fg=green,bg=black]#(tmux-mem-cpu-load --colors --interval 2)#[default]"
        set -g status-left-length 60
        set-option -g status on
        set-option -g status-interval 1
        set-option -g status-justify centre
        set-option -g status-keys vi
        set-option -g status-position bottom
        set-option -g status-style fg=colour136,bg=colour235
        set-option -g status-left-length 20
        set-option -g status-left-style default
        set-option -g status-left "#[fg=green]#H #[fg=black]• #[fg=green,bright]#(uname -r)#[default]"
        set-option -g status-right-length 140
        set-option -g status-right-style default
        set-option -g status-right "#[fg=green,bg=default,bright]#(tmux-mem-cpu-load) "
        set-option -ag status-right "#[fg=red,dim,bg=default]#(uptime | cut -f 4-5 -d ' ' | cut -f 1 -d ',') "
        set-option -ag status-right " #[fg=white,bg=default]%a%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d"
        set-window-option -g window-status-style fg=colour244
        set-window-option -g window-status-style bg=default
        set-window-option -g window-status-current-style fg=colour166
        set-window-option -g window-status-current-style bg=default
      '';
    };

    bash = {
      enable = true;
      sessionVariables.EDITOR = "vim";
      bashrcExtra = ''
        alias ls='exa'

        # prompt
        PS1="\w> "

        neofetch --disable gpu
      '';
    };

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
        map <C-i> :VimwikiIndex<CR>

        nnoremap 1 1gt
        nnoremap 2 2gt
        nnoremap 3 3gt
        nnoremap 4 4gt
        nnoremap 5 5gt
        nnoremap 6 6gt
        nnoremap 7 7gt
        nnoremap 8 8gt
        nnoremap 9 9gt

        let g:vimwiki_list = [{'path': '~/Notes', 'path_html': '~/.config/wiki', 'ext': 'md', 'syntax': 'markdown'}]
      '';

      # to see available plugins:
      # nix-env -f '<nixpkgs>' -qaP -A vimPlugins
      plugins = with pkgs.vimPlugins; [
        # writing
        goyo # distraction-free writing; toggle with :Goyo
        vim-pencil # better word-wrapping, markdown, etc.
        limelight-vim # highlight only current paragraph
        vimwiki

        # search
        ctrlp

        # sidebar
        nerdtree

        # languages
        vim-nix
        swift-vim

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

  xresources.properties = {
    "Xcursor.theme" = "deepin";
    "Xcursor.size" = "96";
    "Xft.dpi" = "155";
  };

  home.file = {
    ".config/sway" = {
      source = ./desktop/sway;
      recursive = true;
    };

    ".config/waybar" = {
      source = ./desktop/sway/waybar;
      recursive = true;
    };

    ".config/ranger" = {
      source = ./applications/ranger;
      recursive = true;
    };

    ".templates" = {
      source = ./templates;
      recursive = true;
    };

    # .desktop files
    #".local/share/applications" = {
    #  source = ./applications/desktopfiles;
    #  recursive = true;
    #};

    #".config/Typora/themes" = {
    #  source = ./typora/themes;
    #  recursive = true;
    #};

    ".config/i3/status.toml".source = ./desktop/i3/i3status-rust.toml;
  };



  home = {
    packages = [
      pkgs.brave
    ];
    sessionVariables = {
      EDITOR = "vim";
      LANG = "en_US.UTF-8";
      PATH = "~/.cargo/bin:$PATH";
    };

    stateVersion = "19.09";
  };
}
